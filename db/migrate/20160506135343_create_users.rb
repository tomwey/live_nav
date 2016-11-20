class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :avatar
      t.string :mobile, null: false
      t.string :password_digest
      t.string :private_token
      t.boolean :verified, default: true
      t.boolean :visible, default: true
      t.integer :uid

      t.timestamps null: false
    end
    add_index :users, :mobile, unique: true
    add_index :users, :private_token, unique: true
    add_index :users, :uid, unique: true
  end
end
