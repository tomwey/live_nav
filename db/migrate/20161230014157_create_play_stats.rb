class CreatePlayStats < ActiveRecord::Migration
  def change
    create_table :play_stats do |t|
      t.string :playable_type, null: false
      t.string :playable_id,   null: false
      t.string :udid
      t.string :device_model
      t.string :os_version
      t.string :app_version
      t.string :screen_size
      t.string :lang_country
      t.string :platform
      t.boolean :is_broken, default: false
      t.string :network_type
      
      t.timestamps null: false
    end
  end
end
