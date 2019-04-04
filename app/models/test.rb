class Test < Evaluation

	scope :active_test_next_saturday, -> {where("start > #{self.next_saturday_test}")}

	def self.check_actives_tests
		self.generate_next_test if self.active_test_next_saturday?
	end

	def self.active_test_next_saturday?
		self.activa.where("start > #{self.next_saturday_test}").count < 1
	end

	def self.generate_next_test

        elem = Test.new
        cost = GeneralParameter.costo_prueba.value
        schedule = GeneralParameter.horario_prueba.value
        location = GeneralParameter.ubicacion_prueba

        elem.start = self.next_saturday_test
        elem.cost = cost
        elem.schedule_id = schedule
        elem.location = location

        elem.save
		
	end


	def self.next_saturday_test
		wtoday = Time.now.wday

		next_test = 6 - wtoday
		next_test += 7 if wtoday > 3
		return Date.today+next_test.days
	end

end
