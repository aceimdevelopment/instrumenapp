class AreaCourse < ApplicationRecord
	
	belongs_to :area
	belongs_to :course

	accepts_nested_attributes_for :course, allow_destroy: true
	accepts_nested_attributes_for :area, allow_destroy: true

	validates :area_id, presence: true
	validates :course_id, presence: true

end
