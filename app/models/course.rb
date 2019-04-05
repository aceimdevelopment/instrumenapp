class Course < Evaluation
	has_many :area_courses, dependent: :destroy
	has_many :areas, through: :area_courses	

	accepts_nested_attributes_for :area_courses, allow_destroy: true
	# belongs_to :area #TIPS: It should be a relation join class like: courses_areas  

	def self.actives_areas_ids
		self.activa.joins(:areas).collect{|c| c.areas.ids}.uniq.flatten
	end


	# def actives_areas_ids
	# 	areas_ids = []
	# 	self.activa.each{|c| areas_ids << c.areas.ids}
	# end


	# def date_start
	# 	self.start.strftime('%d / %m / %Y')
	# end
	# def date_end
	# 	self.end.strftime('%d / %m / %Y')
	# end

end
