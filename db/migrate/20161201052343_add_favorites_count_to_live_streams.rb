class AddFavoritesCountToLiveStreams < ActiveRecord::Migration
  def change
    add_column :live_streams, :favorites_count, :integer, default: 0
    add_index :live_streams, :favorites_count
  end
end
