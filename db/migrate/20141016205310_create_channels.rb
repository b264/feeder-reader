class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :language
      t.string :copyright
      t.string :managingEditor
      t.string :webMaster
      t.date :pubDate
      t.date :lastBuildDate
      t.integer :category_id
      t.string :generator
      t.string :docs
      t.integer :cloud_id
      t.integer :ttl
      t.integer :image_id
      t.string :textInput
      t.integer :skipHours_id
      t.integer :skipDays_id

      t.timestamps
    end
  end
end
