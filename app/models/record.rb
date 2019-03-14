class Record < ApplicationRecord
  enum state: [:preinscrito, :inscrito, :aprobado, :aplazado]
  
  belongs_to :student, foreign_key: 'user_id'
  belongs_to :evaluation

  validates_uniqueness_of :user_id, scope: [:evaluation_id], message: 'ya se encuentra inscrito en la evaluación seleccionada.'

  before_validation :set_default_state

  def alert_type
    aux = ''

    if self.aplazado?
        aux = 'danger'
    elsif self.aprobado?
        aux = 'primary'
    elsif self.inscrito?
        aux = 'success'
    else
        aux = 'default'
    end
  	return aux
  end

  protected

  def set_default_state
  	self.state ||= :preinscrito
  end

end
