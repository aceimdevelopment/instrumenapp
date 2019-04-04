class Schedule < ApplicationRecord
  enum evatype: [:prueba, :curso]

  has_many :evaluations

  def self.get_default_test_schedule
  	if aux = GeneralParameter.horario_prueba
  		return self.where(id: aux.value).first
  	else
  		return nil
  	end
  end
end
