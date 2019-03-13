class Evaluation < ApplicationRecord

  enum state: [:abierto, :confirmado]

  belongs_to :language
  belongs_to :area
  
  has_many :records

  validates :start, presence: true
  validates :end, presence: true
  validates :type, presence: true
  validates :language_id, presence: true

  def tipo
    if type.eql? 'Test'
      return 'Prueba'
    elsif type.eql? 'Course'
      return 'Curso'
    else
      return 'Evaluación'
    end
  end

  def total_records
  	records.count
  end

  def description
    "#{language.description} - #{area.description}"
  end

end
