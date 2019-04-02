class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false, primary_key: true, index: true 
      t.string :name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :password, null: false
      t.string :type, null: false
      t.timestamps
    end
  end
end
