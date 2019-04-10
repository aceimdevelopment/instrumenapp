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

	def self.instruction_testday

		"
		<p>El día de la prueba deberá:</p>
		<p>Traer la planilla de inscripción sellada, su C.I. o algún documento emitido por una instancia válida (Colegio de Odontólogos, Médicos, etc.), un diccionario (en físico, NO SE PERMITIRÁN APARATOS ELECTRÓNICOS NI PRÉSTAMOS DE DICCIONARIOS DENTRO DEL AULA) y un lápiz o bolígrafo con que escribir.</p>
		<p>El miércoles siguiente, después de la prueba, usted podrá ingresar a la página para ver su resultado. Si éste es SUFICIENTE, debe imprimir la constancia y llevarla a las oficinas de FUNDEIM de lunes a miércoles de 3:00 a 5:30 p.m. para ser firmada y sellada.</p>
		"		
	end

	def self.normative

		"
		<h4 class='text-center'>NORMATIVA DE LAS PRUEBAS DE SUFICIENCIA DE DOMINIO INSTRUMENTAL DE UN IDIOMA EXTRANJERO PARA CURSAR ESTUDIOS DE POSTGRADO EN LA UCV</h4>
		</br>
		<p>El examen de idioma instrumental se presenta los días sábados a las 8:30 a.m. (EL LUGAR SERÁ CONFIRMADO UNA VEZ USTED FORMALICE LA INSCRIPCIÓN), dura 1 hora y 30 minutos máximo, consta de dos partes (resumen de un texto del área del postgrado en español y la traducción de uno o varios párrafos, también de un texto en el área de postgrado; el examen les indicará cuántos son y cuáles son), y se aprueba con 15 puntos o más.</p>
		<p>El resultado se refleja como SUFICIENTE (aprobado) o INSUFICIENTE (reprobado).</p>
		<p>NO HAY DERECHO A REVISIÓN DE SU PRUEBA si usted no está de acuerdo con la calificación ya que la prueba es revisada por tres (3) profesores antes de emitir el veredicto.</p>
		<p>Usted puede presentar las veces que desee, siguiendo los pasos aquí establecidos. Sin embargo, la Escuela de Idiomas Modernos recomienda que, si usted no aprueba un examen, tome el tiempo necesario para que se prepare mejor, antes de tomarlo de nuevo.</p>
		<p>TODA LA PRUEBA DEBE SER RESPONDIDA EN ESPAÑOL.</p>
		<p>La evaluación por parte de los profesores toma en cuenta la calidad del resumen, la calidad de la traducción (no se exige una calidad de traductor profesional), acentuación, puntuación, y la cohesión y coherencia del texto escrito. Se recomienda escribir en letra legible ya que esto puede afectar la comprensión, por parte del jurado, de lo que usted escribió.</p>
		<p>Usted debe seguir los pasos aquí establecidos para inscribirse para la prueba. Si no aparece en lista el día del examen, NO PODRÁ PRESENTAR ya que los exámenes se preparan los días jueves  y se elaboran con base en la información suministrada por usted. NO SE PODRÁ CAMBIAR  el día del examen si usted cometió un error.</p>
		<p>Si usted se registra para presentar la prueba en una fecha específica, NO PODRÁ CAMBIAR ESA FECHA luego, y perderá el derecho a reclamar el monto pagado por concepto de arancel.</p>
		<p>SI HUBIESE ALGÚN CAMBIO DE FECHA, POR PARTE DE LA ESCUELA DE IDIOMAS MODERNOS O LA U.C.V., DEBIDO A SITUACIONES IMPREVISTAS, USTED SERÁ NOTIFICADO CON POR LO MENOS 24 HORAS DE ANTICIPACIÓN POR EL CORREO ELECTRÓNICO QUE REGISTRA AQUÍ Y LA EIM ASUMIRÁ LOS CAMBIOS SIN QUE USTED TENGA QUE INTERVENIR NUEVAMENTE EN EL PROCESO. NO NOS HACEMOS RESPONSABLES POR ERRORES COMETIDOS POR USTED.</p>
		"
	end


	def self.procedure
		"
		<h4 class='text-center'>PROCEDIMIENTO DE INSCRIPCIÓN EN PRUEBA</h4>
		</br>
		<ol>
		<li>Ingrese a la página para tramitar su preincripción en las pruebas y escoja el postgrado y el idioma en el que va a presentar.</li>
		<li>Lea detenidamente la normativa del programa y acepte las condiciones para poder continuar.</li>
		<li>Imprima la planilla y realice el pago correspondiente (el monto y los datos bancarios aparecerán en la planilla). Puede realizar una transferencia desde el Bco. de Venezuela hacia la cuenta que aparece en su planilla o acercarse a la oficina de FUNDEIM a cancelar por Punto de Venta.</li>
		<li>Diríjase a la oficina de FUNDEIM en los galpones frente a la Facultad de Farmacia con la planilla de inscripción y el comprobante de pago para completar su inscripción en la prueba.</li>
		<li>El horario de atención al público es de lunes a miércoles de 3:00 a 5:30 pm para presentar la prueba el sábado de esa semana.</li>
		<li>Las inscripciones realizadas el jueves serán incluidas en las pruebas del sábado de la semana siguiente.</li>
		</ol>"
	end

end
