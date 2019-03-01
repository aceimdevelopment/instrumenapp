class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
    	t.string :baucher
    	t.references :user, null: false, type: :string
    	t.references :evaluation, null: false
    	t.integer :state, null: false
    	t.index [:user_id, :evaluation_id], unique: true
    end
    add_foreign_key :records, :users, on_delete: :cascade,  on_update: :cascade
    add_foreign_key :records, :evaluations, on_delete: :cascade,  on_update: :cascade
  end
end
