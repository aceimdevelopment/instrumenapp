class Evaluation < ApplicationRecord
  
  enum type_evaluation: [:course, :test]

  belongs_to :lenguage
  has_many :records

  validates :start, presence: true
  validates :type_evaluation, presence: true

end
