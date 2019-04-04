class GeneralParameter < ApplicationRecord

	COSTO_PRUEBA = 'COSTO_PRUEBA'
	HORARIO_PRUEBA = 'HORARIO_PRUEBA'
	UBICACION_PRUEBA = 'UBICACION_PRUEBA'

	def self.costo_prueba
		self.where(id: COSTO_PRUEBA).first 		
	end

	def self.horario_prueba
		self.where(id: HORARIO_PRUEBA).first
	end

	def self.ubicacion_prueba
		self.where(id: UBICACION_PRUEBA).first
	end
end
