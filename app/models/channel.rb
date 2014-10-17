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
    list= Channel.accessible_attributes
    list.delete ''
    list
  end
  
  private
  
  def validate_save
    unless validate_url(self.URL) && update_channel
      self.errors.add :base, 'Unable to connect to feed.'
    end
  end
  def connect_to url
    begin
      open(url)
    rescue
      false
    end
  end
  def update_channel
    begin
      xml= open(self.URL).read
      puts xml #TODO: remove this
      doc= Nokogiri::XML(xml) {|config| config.strict.nonet}
      parse doc, attrs << 'item'
    rescue #Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => er
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
