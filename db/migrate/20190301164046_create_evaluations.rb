class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.datetime :start, null: false
      t.datetime :end
      t.string :location
      t.references :language, null: false, type: :string
      t.integer :type_evaluation, null: false
      t.index [:language_id, :type_evaluation, :start], unique: true
      t.timestamps
    end
    add_foreign_key :evaluations, :languages, on_delete: :cascade,  on_update: :cascade
  end
end