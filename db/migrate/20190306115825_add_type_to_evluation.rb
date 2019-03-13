class AddTypeToEvluation < ActiveRecord::Migration[5.2]
  def change
  	add_column :evaluations, :type, :string, null: false
  	remove_column :evaluations, :type_evaluation
  end
end
