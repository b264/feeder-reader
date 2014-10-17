class Channel < ActiveRecord::Base
  attr_accessible :category_id, :URL, :cloud_id, :copyright, :description, :docs, :generator, :image_id, :language, :lastBuildDate, :link, :managingEditor, :pubDate, :skipDays_id, :skipHours_id, :textInput, :title, :ttl, :webMaster
  validate :validate_save
  
  private
  
  def validate_save
    unless validate_url(self.link) && update_channel
      self.errors.add :base, 'Unable to connect to feed.'
    end
  end
  def validate_url link
    link && connect_to(link)
  end
  def connect_to link
    begin
      open(link)
    rescue
      false
    end
  end
  def update_channel
    begin
      xml = open(self.link).read
      doc = Nokogiri::XML(xml)
      
    rescue
      xml= false
    end
  end
end
