class Channel < ActiveRecord::Base
  attr_accessible :category_id, :cloud_id, :copyright, :description, :docs, :generator,
                  :image_id, :language, :lastBuildDate, :link, :managingEditor,
                  :pubDate, :skipDays_id, :skipHours_id, :textInput, :title, :ttl, :URL,
                  :webMaster
  validate :validate_save
  
  has_many :items, :dependent => :destroy
  
  def validate_url url
    url && connect_to(url)
  end
  def attrs
    Channel.accessible_attributes.reject {|x| x.to_s.empty?}
  end
  def self.refresh
    Channel.all.each do |chan|
      chan.refresh_content
    end
  end
  def updatable_attrs
    attrs.reject {|x| x.to_s== 'URL'}
  end
  def refresh_content
    unless validate_url(self.URL) && update_channel
      self.errors.add :base, 'Unable to connect to feed.'
    end
  end
  
  private
  

  def validate_save
    refresh_content
  end
  def connect_to url
    begin
      open(url)
    rescue
      false
    end
  end
  def clear_content
    self.items.all.each do |item|
      item.destroy
    end
    self.updatable_attrs.each do |attr|
      eval "self.#{attr.to_s}= nil"
    end
  end
  def update_channel
    clear_content
    begin
      xml= open(self.URL).read
      doc= Nokogiri::XML(xml) {|config| config.strict.nonet}
      parse doc, attrs << 'item'
    rescue
      false
    end
  end
  def parse doc, fields
    #TODO: refactor
    fields.each do |attr|
      unless ['URL', ''].include? attr.to_s
        if attr.to_s== 'item'
          doc.xpath('//item').each do |item_node|
            item= self.items.new
            item_node.children.each do |node|
              unless [''].include? node.name.to_s
                if item.methods.include? node.name.to_sym
                  eval "item.#{node.name.to_s}= node.text"
                end
              end
            end
            item.save
          end
        else
          #TODO: refactor
          if self.methods.include? attr.to_sym
            unless doc.xpath("//#{attr.to_s}").empty?
              eval "self.#{attr.to_s}= doc.xpath('//#{attr.to_s}').first.content"
            end
          end
        end
      end
    end
    true #
  end
end
