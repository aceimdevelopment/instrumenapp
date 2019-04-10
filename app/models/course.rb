class Course < Evaluation
	has_many :area_courses, dependent: :destroy
	has_many :areas, through: :area_courses	

	accepts_nested_attributes_for :area_courses, allow_destroy: true
	# belongs_to :area #TIPS: It should be a relation join class like: courses_areas  

	def self.actives_areas_ids
		self.activa.joins(:areas).collect{|c| c.areas.ids}.uniq.flatten
	end

	def self.normative
		"
		<h4 class='text-center'>NORMATIVA DE LAS CURSOS DE DOMINIO INSTRUMENTAL DE UN IDIOMA EXTRANJERO PARA CURSAR ESTUDIOS DE POSTGRADO EN LA UCV</h4>
		</br>		
		<p>El curso dura 7 semanas. Las clases se dictan los días sábados de 8:30 a.m. a 12:45 p.m. Si desea otro horario, y tiene un grupo de por lo menos 10 personas, debe pasar directamente por las oficinas de FUNDEIM de lunes a miércoles de 3:00 a 5:30 p.m. para ver las opciones disponibles.</p>
		<p>Por lo general, solo dictamos el curso de Inglés Instrumental. Si usted desea otro idioma y tiene un grupo de por lo menos 10 personas, debe pasar directamente por las oficinas de FUNDEIM de lunes a miércoles de 3:00 a 5:30 p.m. para ver las opciones disponibles.</p>
		<p>La evaluación final del curso será la prueba de suficiencia de dominio instrumental de un idioma extranjero.</p>
		<p>El resultado se refleja como SUFICIENTE (aprobado) o INSUFICIENTE (reprobado).</p>
		<p>NO HAY DERECHO A REVISIÓN DE SU PRUEBA si usted no está de acuerdo con la calificación ya que la prueba es revisada por tres (3) profesores antes de emitir el veredicto.</p>
		<p>La evaluación por parte de los profesores toma en cuenta la calidad del resumen, la calidad de la traducción (no se exige una calidad de traductor profesional), acentuación, puntuación, y la cohesión y coherencia del texto escrito. Se recomienda escribir en letra legible ya que esto puede afectar la comprensión, por parte del jurado, de lo que usted escribió.</p>"
	end

	def self.procedure
		"
		<h4 class='text-center'>PROCEDIMIENTO DE INSCRIPCIÓN EN CURSO</h4>
		</br>
		<ol>
			<li>Ingrese a la página y regístrese.</li>
			<li>Lea detenidamente la normativa del programa y acepte las condiciones para poder continuar.</li>
			<li>Escoja el postgrado.</li>
			<li>Espere a que se le envíe el correo de confirmación del comienzo del curso y las instrucciones siguientes.</li>
		</ol>"
	end

	# def actives_areas_ids
	# 	areas_ids = []
	# 	self.activa.each{|c| areas_ids << c.areas.ids}
	# end


	# def date_start
	# 	self.start.strftime('%d / %m / %Y')
	# end
	# def date_end
	# 	self.end.strftime('%d / %m / %Y')
	# end

end
