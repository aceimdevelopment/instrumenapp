class Course < Evaluation

	def date_start
		self.start.strftime('%d / %m / %Y')
	end
	def date_end
		self.end.strftime('%d / %m / %Y')
	end

end
