class HomeController < ApplicationController
  layout 'visitors'
  def index
    aux = flash[:error]
    aux2 = flash[:danger]
    aux3 = flash[:success]
    aux4 = flash[:notice]
    reset_session
    flash[:error] = aux
    flash[:danger] = aux2
    flash[:success] = aux3
    flash[:notice] = aux4

    @mainTitle = "Cursos y Pruebas Instrumentales"
    @mainDesc = "Dominio Instrumental de Idiomas Extranjeros"
    @inscription = Inscription.new
    @user = Student.new
    @is_new = true
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
  
      flash[:success] = "¡Bienvenido #{user.name}!" 
      if current_user.is_admin?
        redirect_to general_parameters_path
      else
        redirect_to students_session_path
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

end
