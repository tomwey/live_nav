class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.datetime :started_at, null: false, index: true
      t.datetime :ended_at, null: false
      t.integer :pl_id
      t.string :vod_url
      t.references :channel, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :playlists, :pl_id, unique: true
  end
end
