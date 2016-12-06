class CreateBilibilis < ActiveRecord::Migration
  def change
    create_table :bilibilis do |t|
      t.string :content, null: false
      t.references :user, index: true, foreign_key: true
      t.references :bilibiliable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
