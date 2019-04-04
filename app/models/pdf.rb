class Pdf
	include Prawn::View


	def self.records evaluation_id
  		eva = Evaluation.find evaluation_id

		# Variable Locales
		pdf = Prawn::Document.new(top_margin: 20)

		#titulo
		encabezado_central_con_logo pdf, "Listado de Participantes"
		pdf.move_down 10

		pdf.text "#{eva.tipo}: #{eva.description} / Fecha: #{I18n.l(eva.start, format: "%d de %B de %Y")} / Total: #{eva.total_records}", align: :center, size: 12 

		pdf.move_down 10

		#instructor
		# pdf.text "Profesor: #{seccion.descripcion_profesor_asignado}", size: 10
	 
		pdf.move_down 10
		data = [["<b>#</b>", "<b>Nombres</b>", "<b>Cédula</b>", "<b>Correo</b>", "<b>Estado</b>"]]

		inscriptions = eva.inscriptions.sort_by{|h| h.student.last_name}

		inscriptions.each_with_index do |e,i|
			data << [i+1, 
			e.user.inverse_name,
			e.user_id,
			e.user.email,
			e.status.titleize
			]	

		end
		
		t = pdf.make_table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :justify, padding: 3, border_color: '818284'}, :column_widths => {1 => 250})
		t.draw

		return pdf
	end


	def self.make_inscription_flayer inscription_id
		# Variable Locales
		inscription = Inscription.find inscription_id

		pdf = Prawn::Document.new(top_margin: 20)

		#titulo
		encabezado_central_con_logo pdf, "Planilla de Inscripción (Sede Ciudad Universitaria)"

		pdf.move_down 10

		preinscription_data inscription, pdf
		signatures pdf

		pdf.text "----- COPIA DEL ESTUDIANTE -----", size: 10, align: :center

		pdf.image "app/assets/images/tijeras.jpg", position: :lelf, height: 10

		# pdf.add_image_from_file 'app/assets/images/tijeras.jpg', 10, alto_tijeras, 25, nil

		pdf.text "-----------------------------------------------------------------------------------------------------------------------------------------------------------", size: 10

		pdf.move_down 5

		# pdf.add_image_from_file Rutinas.crear_codigo_barra(historial_academico.usuario_ci), 460, 280, nil, 100

		preinscription_data inscription, pdf
		bank_description inscription, pdf
		signatures pdf

		pdf.text "----- COPIA ADMINISTRACIÓN -----", size: 10, align: :center

		return pdf
	end


# -------- PLANILLA INSCRIPCIÓN DE ACEIM -------- #


  # def self.planilla_inscripcion(historial_academico=nil)
  #   pdf = PDF::Writer.new(:paper => "letter")  #:orientation => :landscape, 
  #   t = Time.now

  #   pdf.add_image_from_file 'app/assets/images/logo_fhe_ucv.jpg', 465, 710, 50,nil
  #   pdf.add_image_from_file 'app/assets/images/logo_eim.jpg', 515, 710+10, 50,nil
  #   pdf.add_image_from_file 'app/assets/images/logo_ucv.jpg', 45, 710, 50,nil
  #   pdf.add_image_from_file Rutinas.crear_codigo_barra(historial_academico.usuario_ci), 460, 600, nil, 100
  #   pdf.add_text 480,600,to_utf16("---- #{historial_academico.usuario_ci} ----"),11
    
  #   #texto del encabezado
  #   pdf.add_text 100,745,to_utf16("Universidad Central de Venezuela"),10
  #   pdf.add_text 100,735,to_utf16("Facultad de Humanidades y Educación"),10
  #   pdf.add_text 100,725,to_utf16("Escuela de Idiomas Modernos"),10
  #   pdf.add_text 100,715,to_utf16("Cursos de Extensión EIM-UCV"),10

  #   pdf.text "\n\n\n\n"

  #   return pdf
  # end

  def self.preinscription_data inscription, pdf
    # ------- DATOS DE LA PREINSCRIPCIO -------

	pdf.text "<b>Datos de la Preinscripción:</b>", size: 11, inline_format: true, align: :center
	data = [["<i>Participante:</i>", "<b>#{inscription.user.description if inscription.user}</b>"]]
	data << ["<i>#{inscription.tipo}:</i>", "<b>#{inscription.description}</b>"]

	if eva = inscription.evaluation
		data << ["<i>Horario:</i>", "<b>#{eva.schedule.description}</b>"] if eva.schedule
		data << ["<i>Ubicación:</i>", "<b>#{eva.location}</b>"] 
		data << ["<i>Fecha:</i>", "<b>#{eva.start_to_local}</b>"] 
	else
        location = GeneralParameter.ubicacion_prueba
        schedule = Schedule.get_default_test_schedule 

		data << ["<i>Horario:</i>", "<b>#{schedule.description}</b>"] if schedule
		data << ["<i>Ubicación:</i>", "<b>#{location.value}</b>"] if location
	end

	t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
	t.draw
	pdf.move_down 10

  end

  def self.bank_description inscription, pdf
    # -------- TABLA CUENTA ------- #
	pdf.move_down 10

	pdf.text "<b>Datos de Pago:</b>", size: 11, inline_format: true, align: :center

	data = [["<i>Cuenta:</i>", "<b>Cuenta Corriente # 0102-0140-34000442688-4 del Banco de Venezuela</b>"]]
	data << ["<i>A nombre de:</i>", "FUNDEIM (RIF: J-30174529-9)"]
	cost = inscription.evaluation ? inscription.evaluation.cost : GeneralParameter.costo_prueba

	data << ["<i>Monto:</i>", "#{cost}"]
	data << ["<i>Transacción:</i>", "_________________________ Tipo: T ____ D____ P ____"]

	t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
	t.draw

	pdf.move_down 10

    pdf.text "<b>*** Acepté las condiciones y normativas del programa. ***</b>", size: 10, inline_format: true, align: :center

  end

  def self.signatures pdf
    # -- FIRMAS -----
	data = [["<b>__________________________</b>", "<b>__________________________</b>"]]
	data << ["<b>Firma</b>", "<b>Firma Autorizada y Sello</b>"]

	t = pdf.make_table(data, width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :center, padding: 3, border_color: 'FFFFFF'})
	t.draw
    
  end

# -------- FIN PLANILLA INSCRIPCIÓN DE ACEIM -------- #




	private

	def self.encabezado_central_con_logo pdf, titulo

		logo_ucv = "app/assets/images/logo_ucv.png"
		logo_fhe = "app/assets/images/logo_fhe.png"
		logo_eim = "app/assets/images/logo_eim.jpg"


		data = [[{image: logo_fhe, scale: 0.3, position: :center}, {image: logo_ucv, scale: 0.3, position: :center}, {image: logo_eim, scale: 0.3, position: :center}]]

		t = pdf.make_table(data, width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :center, padding: 3, border_color: 'FFFFFF'})

		t.draw


		# pdf.image "app/assets/images/logo_ucv.png", position: :center, height: 50#, valign: :top
		# pdf.image "app/assets/images/logo_fhe.png", position: :left, height: 50#, valign: :top
		# pdf.image "app/assets/images/logo_eim.jpg", position: :right, height: 50#, valign: :top



		pdf.move_down 5
		pdf.text "UNIVERSIDAD CENTRAL DE VENEZUELA", align: :center, size: 12
		pdf.move_down 5
		pdf.text "FACULTAD DE HUMANIDADES Y EDUCACIÓN", align: :center, size: 12
		pdf.move_down 5
	    pdf.text "ESCUELA DE IDIOMAS MODERNOS", align: :center, size: 12
		pdf.move_down 5
		pdf.text "Cursos de Extensión EIM-UCV", align: :center, size: 12
		pdf.move_down 5

		# return pdf
	end


end