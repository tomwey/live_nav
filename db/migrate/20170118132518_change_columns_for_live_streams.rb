class ChangeColumnsForLiveStreams < ActiveRecord::Migration
  def change
    change_column :live_streams, :source_room_id, :string
  end
end
