class Evaluation < ApplicationRecord
  
  emun type_evaluation: [:course, :test]

  belongs_to :lenguage
  has_many :records

  validates :start, presence: true
  validates :type, presence: true

end
