class CreateGeneralParameter < ActiveRecord::Migration[5.2]
  def change
    create_table :general_parameters, id: false do |t|
    	t.string :id, null: false, primary_key: true, index: true
    	t.string :value, null: false
    end
  end
end
