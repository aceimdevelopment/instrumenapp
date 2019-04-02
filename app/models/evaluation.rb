class Evaluation < ApplicationRecord

  # RELATIONSHIPS

  enum status: [:activa, :archivada]

  has_many :inscriptions

  belongs_to :schedule

  # VALIDATIONS

  validates :start, presence: true
  validates :type, presence: true

  before_validation :set_default_state

  # PUBLIC FUNCTIONS
  def tipo
    if type.eql? 'Test'
      return 'Prueba'
    elsif type.eql? 'Course'
      return 'Curso'
    else
      return 'Evaluación'
    end
  end

  def total_inscriptions
  	inscriptions.count
  end


  # PROTECTED FUNCTIONS

  protected

  def set_default_state
    self.status ||= :preinscrito
  end


end
