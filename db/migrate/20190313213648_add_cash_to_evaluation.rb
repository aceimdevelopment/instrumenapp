class AddCashToEvaluation < ActiveRecord::Migration[5.2]
  def change
  	add_column :evaluations, :cost, :integer, default: 0
  end
end
