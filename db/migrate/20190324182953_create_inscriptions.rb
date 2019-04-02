class CreateInscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :inscriptions do |t|
      t.integer :score, default: 0 # 0: aplazado, 1: aprobado
      t.string :baucher
      t.integer :status, default: 0 # 0: preinscrito, 1:confirmado
      t.integer :evatype, null: false
      t.references :language, null: false, type: :string
      t.references :area
      t.references :user, null: false, type: :string
      t.references :evaluation
      t.timestamps
      t.index [:language_id, :area_id, :user_id, :evatype], unique: true, name: 'uq_language_area_user_evatype'
    end
    add_foreign_key :inscriptions, :languages, on_delete: :cascade,  on_update: :cascade
    add_foreign_key :inscriptions, :areas, on_delete: :cascade,  on_update: :cascade
    add_foreign_key :inscriptions, :users, on_delete: :cascade,  on_update: :cascade
    add_foreign_key :inscriptions, :evaluations, on_delete: :cascade,  on_update: :cascade

  end
end
