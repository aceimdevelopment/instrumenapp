class GeneralParameter < ApplicationRecord

	COSTO_PRUEBA = 'COSTO_PRUEBA'
	HORARIO_PRUEBA = 'HORARIO_PRUEBA'

	def self.costo_prueba
		self.find COSTO_PRUEBA
		
	end

	def self.horario_prueba
		self.find HORARIO_PRUEBA		
	end

	def self.ubicacion_prueba
		
	end
end
