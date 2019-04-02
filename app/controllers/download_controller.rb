class DownloadController < ApplicationController

	def make_inscription
		pdf = Pdf.make_inscription_flayer params[:id]
		unless send_data pdf.render, filename: "planilla_inscripcion_#{params[:id].to_s}.pdf", type: "application/pdf", disposition: "attachment"
			flash[:error] = "En estos momentos no se pueden descargar el archivo solicitado, intentelo más tarde."
		end
		return
	end

	def make_evaluation_list
		pdf = Pdf.records params[:id]
		unless send_data pdf.render, filename: "list_evaluacion_#{params[:id].to_s}.pdf", type: "application/pdf", disposition: "attachment"
			flash[:error] = "En estos momentos no se pueden descargar el archivo solicitado, intentelo más tarde."
		end
		return
	end

	# def constancia_estudio
	# 	pdf = ExportarPdf.hacer_constancia_estudio params[:id], current_periodo.id, params[:escuela_id]
	# 	unless send_data pdf.render,:filename => "constancia_estudio_#{params[:id].to_s}.pdf",:type => "application/pdf", :disposition => "attachment"
	# 		flash[:error] = "En estos momentos no se pueden descargar el acta, intentelo más tarde."
	# 	end
	# 	return
		
	# end

end
