class AddSourceNameAndSourceRoomIdAndOnlineToLiveStreams < ActiveRecord::Migration
  def change
    add_column :live_streams, :source_name, :string
    add_column :live_streams, :source_room_id, :integer
    add_column :live_streams, :online, :boolean, default: true
  end
end
