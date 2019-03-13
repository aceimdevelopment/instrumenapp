class Record < ApplicationRecord
  enum state: [:preinscrito, :inscrito, :aprobado]
  
  belongs_to :student, foreign_key: 'user_id'
  belongs_to :evaluation

  validates_uniqueness_of :user_id, scope: [:evaluation_id], message: 'Ya se encuentra inscrito en la evaluación seleccionada.', 'field_name': false
	# validates_uniqueness_of :estudiante_id, scope: [:periodo_id], message: 'El estudiante ya tiene un plan para el periodo', field_name: false

  before_validation :set_default_state

  protected

  def set_default_state
  	self.state ||= :preinscrito
  end

end
