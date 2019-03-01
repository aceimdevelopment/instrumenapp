class Language < ApplicationRecord
	has_many :evaluations

	validates :id, presence: true, uniqueness: true
	validates :description, presence: true

end
