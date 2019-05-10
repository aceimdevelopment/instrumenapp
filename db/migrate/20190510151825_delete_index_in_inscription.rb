class DeleteIndexInInscription < ActiveRecord::Migration[5.2]
  def change
  	remove_index :inscriptions, name: 'uq_language_area_user_evatype'

  end
end
