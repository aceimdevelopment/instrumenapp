class Inscription < ApplicationRecord

  belongs_to :language
  belongs_to :area
  belongs_to :evaluation, optional: true
  belongs_to :user#, foreign_key: 'user_id', primary_key: 'user_id'

  enum status: [:preinscrito, :inscrito, :aprobado, :aplazado]


  validates_uniqueness_of :language_id, scope: [:area_id, :user_id, :evatype], message: 'Ya se se encuentra (pre)inscrita(o) en la evaluación indicada. Porfavor, ingrese a su sessión y consulte las opciones', if: :same_inscription


  def same_inscription

    evatype_value = Inscription.evatypes[self.evatype]
    self.new_record? and (Inscription.where("language_id = ? and area_id = ? and user_id = ? and evatype = ? and (status = 0 or status = 1)", self.language_id, self.area_id, self.user_id, evatype_value).count > 0)
    
  end

  enum evatype: [:course, :test]


  # scope :no_pcis, lambda { |periodo_id| joins(:programaciones).where('programaciones.periodo_id = ? and programaciones.pci IS FALSE', periodo_id) }

  scope :pendents, -> {where('status = 0 || status = 1')}


  def status_like_pass
    if self.aprobado?
      'aprobó'
    elsif self.aplazado?
      'aplazó'
    else
      'sin información'
    end
  end

  def link_title
    if self.test?
      "Prueba de Dominio Instrumental de Idiomas Extranjeros para Postgrado"
    elsif self.course?
      "Realizar Curso Instrumental Inglés"
    else
      "Realizar Evaluación"
    end

  end

  def description
    aux = ""
    aux += "#{language.description.titleize}" #if language.description
    aux += " - #{area.description.titleize}" #if area.description
    aux += " (#{evaluation.title})" if evaluation and evaluation.title
    return aux
  end


  def tipo
    if course?
      aux = "Curso"
    elsif test?
      aux = "Prueba"
    else
      aux = "Evaluacion"
    end
    return aux
  end


  before_validation :set_default_state

  def alert_type
    aux = ''

    if self.aplazado?
        aux = 'danger'
    elsif self.aprobado?
        aux = 'primary'
    elsif self.inscrito?
        aux = 'success'
    else
        aux = 'default'
    end
    return aux
  end

  protected

  def set_default_state
    self.status ||= :preinscrito
  end

 
end
