class AddChannelIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :channel_id, :integer
  end
end
