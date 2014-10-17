class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :author
      t.integer :category_id
      t.string :comments
      t.string :enclosure
      t.string :guid
      t.date :pubDate
      t.string :source
      
      t.timestamps
    end
  end
end
