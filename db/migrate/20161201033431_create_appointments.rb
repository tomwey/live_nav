class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :playlist, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
