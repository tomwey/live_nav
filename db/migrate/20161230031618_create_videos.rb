class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :vid, index: true, unique: true
      t.string :name, null: false
      t.string :intro
      t.string :image, null: false
      t.string :live_url, null: false
      t.integer :view_count, default: 0
      t.integer :sort, default: 0
      t.boolean :opened, default: true
      t.string :source_name
      t.string :source_id

      t.timestamps null: false
    end
    add_index :videos, :sort
  end
end
