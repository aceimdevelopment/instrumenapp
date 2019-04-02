class Schedule < ApplicationRecord
  enum evatype: [:prueba, :curso]

  has_many :evaluations
end
