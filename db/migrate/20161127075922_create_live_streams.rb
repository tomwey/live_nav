class CreateLiveStreams < ActiveRecord::Migration
  def change
    create_table :live_streams do |t|
      t.integer :sid
      t.string :name, null: false
      t.string :intro
      t.string :image, null: false
      t.string :live_url, null: false
      t.integer :sort, default: 0
      t.boolean :opened, default: true

      t.timestamps null: false
    end
    add_index :live_streams, :sid, unique: true
    add_index :live_streams, :sort
  end
end
