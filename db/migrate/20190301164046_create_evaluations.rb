class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.string :type, null: false
      t.string :title
      t.date :start, null: false
      t.string :location
      t.references :schedule
      t.string :cost
      t.integer :status, default: 0
      t.timestamps
    end
    add_foreign_key :evaluations, :schedules, on_delete: :cascade,  on_update: :cascade
  end
end