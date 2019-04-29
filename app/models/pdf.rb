class Pdf
	include Prawn::View


	def self.inscriptions evaluation_id
  		eva = Evaluation.find evaluation_id

		# Variable Locales
		pdf = Prawn::Document.new(top_margin: 20)

		#titulo
		encabezado_central_con_logo pdf, "Listado de Participantes"
		pdf.move_down 10

		pdf.text "<b>#{eva.tipo}:</b> #{eva.description} / <b>Fecha:</b> #{eva.start_to_local} / <b>Total:</b> #{eva.total_inscriptions}", align: :center, size: 12, inline_format: true

		pdf.move_down 10

		#instructor
		# pdf.text "Profesor: #{seccion.descripcion_profesor_asignado}", size: 10
	 
		pdf.move_down 10
		data = [["<b>#</b>", "<b>Nombres</b>", "<b>Cédula</b>", "<b>Idioma</b>", "<b>Área</b>", "<b>Correo</b>", "<b>Teléfono</b>", "<b>Estado</b>"]]

		inscriptions = eva.inscriptions.sort_by{|h| h.user.last_name}

		inscriptions.each_with_index do |e,i|
			lan = e.language.description if e.language
			area = e.area.description if e.area
			data << [i+1, 
			e.user.inverse_name,
			e.user_id,
			lan,
			area,
			e.user.email,
			e.user.phone,
			e.status.titleize
			]	
		end
		
		t = pdf.make_table(data, header: true, row_colors: ["F0F0F0", "FFFFFF"], width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :justify, padding: 3, border_color: '818284'}, :column_widths => {1 => 180})
		t.draw

		return pdf
	end


	def self.make_inscription_flayer inscription_id
		# Variable Locales
		inscription = Inscription.find inscription_id

		pdf = Prawn::Document.new(top_margin: 20)

		#titulo
		encabezado_central_con_logo_low pdf#, "Planilla de Inscripción (Sede Ciudad Universitaria)"

		pdf.move_down 5

		preinscription_data inscription, pdf
		bank_description inscription, pdf
		factures_data inscription, pdf

		if inscription.test?

			pdf.text '<b>El día de la prueba deberá:</b>', size: 9, inline_format: true, align: :center
			pdf.text 'Traer la planilla de inscripción sellada, su C.I. o algún documento emitido por una instancia válida (Colegio de Odontólogos, Médicos, etc.), un diccionario (en físico, NO SE PERMITIRÁN APARATOS ELECTRÓNICOS NI PRÉSTAMOS DE DICCIONARIOS DENTRO DEL AULA) y un lápiz o bolígrafo con que escribir.', size: 9, inline_format: true, align: :justify
			pdf.text 'El miércoles siguiente, después de la prueba, usted podrá ingresar a la página para ver su resultado. Si éste es SUFICIENTE, debe imprimir la constancia y llevarla a las oficinas de FUNDEIM de lunes a miércoles de 3:00 a 5:30 p.m. para ser firmada y sellada.', size: 9, inline_format: true, align: :justify
		else
			pdf.move_down 10

		end

		pdf.move_down 10
		pdf.text "<b>*** Acepté las condiciones y normativas del programa. ***</b>", size: 10, inline_format: true, align: :center
		pdf.move_down 10
		signatures pdf
		pdf.move_down 10
		pdf.text "----- COPIA DEL ESTUDIANTE -----", size: 10, align: :center

		pdf.image "app/assets/images/tijeras.jpg", position: :lelf, height: 10

		pdf.text "---------------------------------------------------------------------------------------------------------------------------------------", size: 12

		pdf.move_down 10

		# pdf.add_image_from_file Rutinas.crear_codigo_barra(historial_academico.usuario_ci), 460, 280, nil, 100

		preinscription_data inscription, pdf
		bank_description inscription, pdf
		pdf.move_down 10
		pdf.text "<b>*** Acepté las condiciones y normativas del programa. ***</b>", size: 10, inline_format: true, align: :center
		pdf.move_down 10
		signatures pdf

		pdf.move_down 10
		pdf.text "----- COPIA ADMINISTRACIÓN -----", size: 10, align: :center

		return pdf
	end


	def self.make_doc_approval inscription_id
		# Variable Locales
		inscription = Inscription.find inscription_id
		student = inscription.user

		pdf = Prawn::Document.new(top_margin: 50, left_margin: 70, right_margin: 70)

		#titulo
		encabezado_central_con_logo_low pdf#, "Planilla de Inscripción (Sede Ciudad Universitaria)"

		pdf.move_down 50

		pdf.text "<u>CONSTANCIA</u>", size: 12, inline_format: true, align: :center

		pdf.move_down 20

		pdf.text "Quien suscribe, profesor  <i><b>LUCIUS DANIEL</b></i>, Director de la Escuela de Idiomas Modernos de la Facultad de Humanidades y Educación de la Universidad Central de Venezuela, hace constar por medio de la presente  que  la/el ciudadano (a) <b>#{student.inverse_name}</b>,  titular  de la cédula de identidad <b> C.I.: #{student.id}</b>, <b>#{inscription.status_like_pass}</b> el examen de suficiencia  para la  consulta bibliográfica y el uso instrumental del idioma : <b>#{inscription.language.description.upcase}</b> en el área de <b>#{inscription.area.description.upcase}</b>.", size: 11, inline_format: true, align: :justify, leading: 10, indent_paragraphs: 20

		pdf.move_down 20
		date = I18n.l(Date.today, format: 'Constancia que se expide en Caracas a los %d día(s) del mes de %B de %Y.')

		pdf.text date, size: 11, inline_format: true, align: :justify
		
		if inscription.test? and inscription.evaluation
			pdf.move_down 30
			pdf.text "Fecha  de presentación de la prueba: <b>#{inscription.evaluation.start_to_local '%A, %d de %B de %Y' }</b>", size: 11, inline_format: true
		end
		
		pdf.move_down 100
		pdf.text "Prof. Lucius Daniel", size: 11, inline_format: true, align: :center
		pdf.text "Director", size: 11, inline_format: true, align: :center

		pdf.move_down 30
		pdf.text '<b>Nota: esta constancia tiene una vigencia de dos años a partir del momento en que se presentó la prueba.</b>', size: 10, inline_format: true, align: :justify

		pdf.text_box('Al contestar, se agradece hacer referencia al número y fecha de esta comunicación.
     Ciudad Universitaria, Galpones N° 7, frente a Farmacia. Telefax: 6052924',
 at: [0, 30], size: 9, align: :center)


		return pdf
	end


	# -------- PLANILLA INSCRIPCIÓN DE ACEIM -------- #
	private

	def self.preinscription_data inscription, pdf
	# ------- DATOS DE LA PREINSCRIPCIO -------

		pdf.text "<b>Datos de Preinscripción en #{inscription.tipo.titleize} de #{inscription.description}</b>", size: 11, inline_format: true, align: :center
		data = [["<i>Participante:</i>", "<b>#{inscription.user.description if inscription.user}</b>"]]

		if eva = inscription.evaluation
			data << ["<i>#{inscription.tipo}:</i>", "<b>#{eva.start_to_local} (#{eva.schedule.description if eva.schedule }) Ubicación: #{eva.location} </b>"]
		else
			location = GeneralParameter.ubicacion_prueba
			schedule = Schedule.get_default_test_schedule 

			data << ["<i>#{inscription.tipo}:</i>", "<b>______________________________ (#{schedule.description if schedule }) Ubicación:</b> #{location.value if location} "]
		end

		t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
		t.draw
		pdf.move_down 10

	end


	def self.factures_data inscription, pdf
		# -------- TABLA CUENTA ------- #
		pdf.text "<b>Datos de Facturación:</b>", size: 10, inline_format: true

		data = [["<i>A nombre de:</i>", "__________________________________________________________________________________________"]]
		data << ["<i>CI ó RIF:</i>", "______________________________________ <i> Núm. Telefónico:</i> _____________________________________"]
		data << ["<i>Dirección Fiscal:</i>", "__________________________________________________________________________________________"]

		t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
		t.draw

		pdf.move_down 10

	end



	def self.bank_description inscription, pdf
		# -------- TABLA CUENTA ------- #

		pdf.text "<b>Datos de Pago:</b>", size: 11, inline_format: true, align: :center

		data = [["<i>Cuenta:</i>", "<b>Cuenta Corriente # 0102-0140-34000442688-4 del Banco de Venezuela</b>"]]
		data << ["<i>A nombre de:</i>", "<b>FUNDEIM (RIF: J-30174529-9)</b>"]
		cost = inscription.evaluation ? inscription.evaluation.cost : GeneralParameter.costo_prueba.value

		data << ["<i>Monto:</i>", "<b>#{cost}</b> <i> Transacción: </i> ___________________________ T ____ D____ P ____ "]

		t = pdf.make_table(data, width: 540, cell_style: { inline_format: true, size: 9, align: :left, padding: 3, border_color: 'FFFFFF'}, :column_widths => {0 => 80})
		t.draw

		pdf.move_down 6

	end

	def self.signatures pdf
		# -- FIRMAS -----
		data = [["<b>__________________________</b>", "<b>__________________________</b>"]]
		data << ["<b>Firma del Estudiante</b>", "<b>Firma Fundeim y Sello</b>"]

		t = pdf.make_table(data, width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :center, padding: 3, border_color: 'FFFFFF'})
		t.draw

	end

	# -------- FIN PLANILLA INSCRIPCIÓN DE ACEIM -------- #


	def self.encabezado_central_con_logo_low pdf

		logo_ucv = "app/assets/images/logo_ucv.png"
		logo_fhe = "app/assets/images/logo_fhe.png"
		logo_eim = "app/assets/images/logo_eim.jpg"


		data = [[{image: logo_fhe, scale: 0.3, position: :center}, {image: logo_ucv, scale: 0.3, position: :center}, {image: logo_eim, scale: 0.3, position: :center}]]

		t = pdf.make_table(data, width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :center, padding: 3, border_color: 'FFFFFF'})

		t.draw

		pdf.move_down 5
		pdf.text "UNIVERSIDAD CENTRAL DE VENEZUELA", align: :center, size: 9
		pdf.move_down 3
		pdf.text "FACULTAD DE HUMANIDADES Y EDUCACIÓN", align: :center, size: 9
		pdf.move_down 3
	    pdf.text "ESCUELA DE IDIOMAS MODERNOS", align: :center, size: 9
		pdf.move_down 3
		pdf.text "Cursos de Postgrado EIM-UCV", align: :center, size: 9
		pdf.move_down 3

		# return pdf
	end


	def self.encabezado_central_con_logo pdf, titulo

		logo_ucv = "app/assets/images/logo_ucv.png"
		logo_fhe = "app/assets/images/logo_fhe.png"
		logo_eim = "app/assets/images/logo_eim.jpg"


		data = [[{image: logo_fhe, scale: 0.3, position: :center}, {image: logo_ucv, scale: 0.3, position: :center}, {image: logo_eim, scale: 0.3, position: :center}]]

		t = pdf.make_table(data, width: 540, position: :center, cell_style: { inline_format: true, size: 9, align: :center, padding: 3, border_color: 'FFFFFF'})

		t.draw

		pdf.move_down 5
		pdf.text "UNIVERSIDAD CENTRAL DE VENEZUELA", align: :center, size: 12
		pdf.move_down 5
		pdf.text "FACULTAD DE HUMANIDADES Y EDUCACIÓN", align: :center, size: 12
		pdf.move_down 5
	    pdf.text "ESCUELA DE IDIOMAS MODERNOS", align: :center, size: 12
		pdf.move_down 5
		pdf.text "Cursos de Postgrado EIM-UCV", align: :center, size: 12
		pdf.move_down 5

		# return pdf
	end


end