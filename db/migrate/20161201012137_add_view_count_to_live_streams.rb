class AddViewCountToLiveStreams < ActiveRecord::Migration
  def change
    add_column :live_streams, :view_count, :integer, default: 0
    add_index :live_streams, :view_count
  end
end
