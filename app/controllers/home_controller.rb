class HomeController < ApplicationController
  layout 'visitors'
  def index
    @mainTitle = "Cursos y Pruebas Instrumentales"
    @mainDesc = "Dominio Instrumental de Idiomas Extrangeros"
  end


  def authenticate
    unless params[:user]
      flash[:danger] = "Error, debe ingresar Cédula y contraseña"
      redirect_to root_path
    end
    login = params[:user][:id]
    clave = params[:user][:password]
    reset_session
    if user = User.authenticate(login, clave)
      session[:user_id] = user.id
  
      flash[:success] = "Bienvenido #{user.name}" 
      if current_user.admin?
        redirect_to admin_sessions_path
      else
        redirect_to user_sessions_path
      end

    else
      flash[:error] = "Error en cédula o contraseña"
      redirect_to root_path
    end
  end 


  def logout
    msg = "¡Hasta pronto #{current_user.name}!"
    reset_session
    flash[:success] = msg
    redirect_to root_path
  end 

  def minor
  end
end
