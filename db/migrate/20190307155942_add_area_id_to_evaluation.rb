class AddAreaIdToEvaluation < ActiveRecord::Migration[5.2]
  def change
	add_reference :evaluations, :area, index: true
	add_foreign_key :evaluations, :areas, on_delete: :cascade, on_update: :cascade 
  end
end
