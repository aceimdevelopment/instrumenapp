class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :description
      t.integer :evatype, null: false
      t.timestamps
    end
  end
end
