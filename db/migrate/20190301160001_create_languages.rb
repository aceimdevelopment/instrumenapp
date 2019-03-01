class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages, id: false do |t|
      t.string :id, null: false, primary_key: true, index: true 
      t.string :description, null: false
      t.timestamps
    end
  end
end
