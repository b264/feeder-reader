class RemoveItemIdFromChannels < ActiveRecord::Migration
  def up
    remove_column :channels, :item_id
  end

  def down
    add_column :channels, :item_id, :integer
  end
end
