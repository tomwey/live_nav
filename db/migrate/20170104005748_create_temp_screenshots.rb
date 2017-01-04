class CreateTempScreenshots < ActiveRecord::Migration
  def change
    create_table :temp_screenshots do |t|
      t.string :image, null: false
      t.references :channel, index: true, foreign_key: true
      t.datetime :upload_at, null: false

      t.timestamps null: false
    end
  end
end
