class AddUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :URL, :string
  end
end
