class Channel < ActiveRecord::Base
  attr_accessible :category_id, :cloud_id, :copyright, :description, :docs, :generator,
                  :image_id, :language, :lastBuildDate, :link, :managingEditor,
                  :pubDate, :skipDays_id, :skipHours_id, :textInput, :title, :ttl, :URL,
                  :webMaster
  validate :validate_save
  
  has_many :items
  
  def validate_url url
    url && connect_to(url)
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
    #begin
      xml= open(self.URL).read
      puts xml #TODO: remove this
      doc= Nokogiri::XML(xml) {|config| config.strict.nonet}
      parse doc, Channel.accessible_attributes
    #rescue #Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => er
      #false
    #end
  end
  def parse doc, fields
    fields.each do |attr|
      unless ['URL', ''].include? attr.to_s
        if self.methods.include? attr.to_sym
          unless doc.xpath("//#{attr.to_s}").empty?
            case attr.to_s
              when 'item'
                
              else
                #TODO: security hole, code execution
                eval "self.#{attr.to_s}= doc.xpath('//#{attr.to_s}').first.content"
            end
          end
        end
      end
    end
    true #
  end
end
