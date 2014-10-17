class Item < ActiveRecord::Base
  attr_accessible :title, :link, :description, :channel_id, :author, :category_id,
                  :comments, :enclosure, :guid, :pubDate, :source
  
  belongs_to :channel, :inverse_of => :item
  
  def attrs
    Item.accessible_attributes.reject {|x| x.to_s.empty?}
  end
  
end
