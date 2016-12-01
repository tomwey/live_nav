class AddFavoritesCountToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :favorites_count, :integer, default: 0
    add_index :channels, :favorites_count
  end
end
