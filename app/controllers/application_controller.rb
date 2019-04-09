class ApplicationController < ActionController::Base
	helper_method :current_user 

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def login_filter
		unless session[:user_id]
			reset_session
			flash[:danger] = "Debe iniciar sesión"
			redirect_to root_path
			# return false
		end
	end
	
	def admin_filter
		if !(session[:user_id] and User.find(session[:user_id]).is_admin?)
			reset_session
			flash[:danger] = "Debe iniciar sesión como Administrador"  
			redirect_to root_path
			# return false
		end
	end


end
