class AddPlayCountAndAppointmentsCountToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :play_count, :integer, default: 0
    add_column :playlists, :appointments_count, :integer, default: 0
  end
end
