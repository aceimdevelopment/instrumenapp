class Evaluation < ApplicationRecord

  # RELATIONSHIPS

  enum status: [:activa, :archivada]

  has_many :inscriptions

  belongs_to :schedule

  # VALIDATIONS

  validates :start, presence: true
  validates :type, presence: true

  before_validation :set_default_state

  scope :old_eva, -> {where("start < '#{Date.today}'")}
  scope :next_eva, -> {where("start >= '#{Date.today}'")}

  def self.archive_old_eva
    self.activa.old_eva.each do |a| 
      a.status = :archivada 
      a.save
    end
  end

  def start_to_local format_default = nil
    format_default = '%a, %d %b %Y' if format_default.blank?
    I18n.l(start, format: format_default).titleize
  end

  def description
    # "#{hour} - #{location} - #{schedule.description if schedule}"
    "#{self.start_to_local} - #{location} - #{schedule.description if schedule}"

  end

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
