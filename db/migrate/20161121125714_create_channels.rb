class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :chn_id
      t.string :name, null: false
      t.string :intro
      t.string :image
      t.string :live_url, null: false
      t.integer :sort, default: 0
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :channels, :chn_id, unique: true
    add_index :channels, :sort
  end
end
