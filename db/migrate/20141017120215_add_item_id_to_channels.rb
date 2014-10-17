class AddItemIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :item_id, :integer
  end
end
