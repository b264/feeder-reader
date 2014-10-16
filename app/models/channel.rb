require 'open-uri'              # allows open('http://...') to return body
require 'cgi'                   # for escaping URIs
require 'nokogiri'              # XML parser
class Channel < ActiveRecord::Base
  class InvalidError < RuntimeError ; end
  class NetworkError < RuntimeError ; end
  class InvalidKeyError < RuntimeError ; end
  attr_accessible :category_id, :cloud_id, :copyright, :description, :docs, :generator, :image_id, :language, :lastBuildDate, :link, :managingEditor, :pubDate, :skipDays_id, :skipHours_id, :textInput, :title, :ttl, :webMaster
  validate :validate_save
  
  
  private
  
  def validate_save
    unless validate_url self.link
      self.errors.add :base, 'Unable to connect to feed.'
    end
    #puts 'rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'
    if update_channel
      #self.save stack overflow!
    end
  end
  def validate_url link
    link && connect_to(link)
  end
  def connect_to link
    open(link)
  end
  def update_channel
    #xml = URI.parse(self.link).read
    
    
    begin
      xml = open(self.link).read
      #TODO
    rescue Errno::ENOENT, Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError => e
      # convert all of these into a generic Channel::NetworkError,
      #  but keep the original error message
      #raise NetworkError, e.message
      xml= false
    end
    
  end
end
