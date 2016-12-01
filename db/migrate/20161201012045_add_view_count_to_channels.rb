class AddViewCountToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :view_count, :integer, default: 0
    add_index :channels, :view_count
  end
end
