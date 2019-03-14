class Test < Evaluation

	def duration
		aux = self.end.hour - self.start.hour
		"#{aux} Horas"
	end
end
