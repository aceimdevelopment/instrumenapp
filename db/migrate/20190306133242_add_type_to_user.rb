class AddTypeToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :type, :string, null: false
  	remove_column :users, :role
  	rename_column :users, :full_name, :last_name
  end
end
