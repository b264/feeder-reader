class Channel < ActiveRecord::Base
  attr_accessible :category_id, :cloud_id, :copyright, :description, :docs, :generator, :image_id, :language, :lastBuildDate, :link, :managingEditor, :pubDate, :skipDays_id, :skipHours_id, :textInput, :title, :ttl, :webMaster
end
