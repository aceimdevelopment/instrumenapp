class Area < ApplicationRecord
	has_many :evaluations

	validates :description, presence: true, uniqueness: { case_sensitive: false }

	before_save :strip_desc
	protected

	def strip_desc
		self.description = self.description.strip
	end
end
