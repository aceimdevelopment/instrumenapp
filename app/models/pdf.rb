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

		records = eva.records.sort_by{|h| h.student.last_name}

		records.each_with_index do |e,i|
			data << [i+1, 
			e.student.inverse_name,
			e.user_id,
			e.student.email,
			e.state.titleize
			]	

		end
		
		t = pdf.make_table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :justify, padding: 3, border_color: '818284'}, :column_widths => {1 => 250})
		t.draw

		return pdf
	end


	def self.make_inscription_flayer record_id
		# Variable Locales
		record = Record.find record_id

		pdf = Prawn::Document.new(top_margin: 20)

		#titulo
		encabezado_central_con_logo pdf, "Planilla de Inscripción (Sede Ciudad Universitaria)"

		pdf.move_down 10

		preinscription_data record, pdf
		bank_description record, pdf
		signatures pdf

		pdf.text "----- COPIA DEL ESTUDIANTE -----", size: 10, align: :center

		pdf.image "app/assets/images/tijeras.jpg", position: :lelf, height: 10

		# pdf.add_image_from_file 'app/assets/images/tijeras.jpg', 10, alto_tijeras, 25, nil

		pdf.text "-----------------------------------------------------------------------------------------------------------------------------------------------------------", size: 10

		pdf.move_down 5

		# pdf.add_image_from_file Rutinas.crear_codigo_barra(historial_academico.usuario_ci), 460, 280, nil, 100

		preinscription_data record, pdf
		bank_description record, pdf
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

  def self.preinscription_data record, pdf
    # ------- DATOS DE LA PREINSCRIPCIO -------

	pdf.text "<b>Datos de la Preinscripción:</b>", size: 11, inline_format: true, align: :center

	data = [["<i>Curso:</i>", "<b>#{record.evaluation.description}</b>"]]
	data << ["<i>Horario:</i>", "<b>Horario</b>"]
	data << ["<i>Ubicación:</i>", "<b>#{record.evaluation.location}</b>"]
	# data << ["<i>Monto:</i>", "<b>#{record.evaluation.cost_to_bs}</b>"]
	# data << ["<i>Transacción:</i>", "_________________________ Tipo: T ____ D____ P ____"]

	t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
	t.draw
	pdf.move_down 10

  end

  def self.bank_description record, pdf
    # -------- TABLA CUENTA ------- #
	pdf.move_down 10

	pdf.text "<b>Datos de Pago:</b>", size: 11, inline_format: true, align: :center

	data = [["<i>Banco:</i>", "<b>Cuenta Corriente _________________________ </b> del Banco de Venezuela"]]
	data << ["<i>A nombre de:</i>", "_________________________"]
	data << ["<i>Monto:</i>", "#{record.evaluation.cost_to_bs}"]
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