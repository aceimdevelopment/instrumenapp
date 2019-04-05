class Area < ApplicationRecord
	has_many :inscriptions
	has_many :area_courses, dependent: :destroy
	has_many :courses, through: :area_courses

	accepts_nested_attributes_for :area_courses, allow_destroy: true

	validates :description, presence: true, uniqueness: { case_sensitive: false }

	before_save :strip_desc

	# scope :preinsc_pendents, -> {joins(:inscriptions).where("evatype = 'course' && status = 'preinscrito'")}
	scope :preinsc_pendents, -> {joins(:inscriptions).where("status = 0 AND evatype = 'course'")}

	
	protected

	def strip_desc
		self.description = self.description.strip
	end
end
