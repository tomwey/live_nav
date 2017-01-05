class AddPyNameToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :py_name, :string
  end
end
