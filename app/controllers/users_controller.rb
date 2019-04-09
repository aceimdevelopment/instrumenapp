class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :reset_pw]

  before_action :login_filter
  before_action :admin_filter

  layout 'visitors', only: [:evaluation]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.limit(50)

    if params['top-search']
      @users = User.search(params['top-search']).limit(50)
      if @users.count > 0 && @users.count < 50  
        flash[:success] = "Total de coincidencias: #{@users.count}"
      elsif @users.count == 0
        flash[:error] = "No se encontraron conincidencas. Intenta con otra búsqueda"
      else
        flash[:error] = "50 o más conincidencia. Puedes ser más explicito en la búsqueda. Recuerda que puedes buscar por CI, Nombre, Apellido, Correo Electrónico o incluso Número Telefónico"
      end
    else
      @users = User.limit(50).order("created_at, last_name, name, id")
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def evaluation
    if params[:id]
      @user = User.where(id: params[:id]).first
      @disabled = true
    else
      @user = User.new
      @disabled = false
    end

    if params[:test]
      @evaluations = Test.abierto
      @eva_title = "Pruebas"
    elsif params[:course]
      @eva_title = "Cursos"
      @evaluations = Course.abierto
    else
      @evaluations = Evaluation.abierto
      @eva_title = "Evaluaciones"
    end
    @eva_title += " Disponibles"
  end

  def destroy_record
    r = Record.find params[:id]
    @evaluation = r.evaluation
    flash[:info] = "Registro de inscripción elimnado con éxito" if r.destroy
    redirect_back fallback_location: @evaluation

  end

  def record_in_evaluation
    if !params[:id] and Student.where(id: user_params[:id]).count > 0
        flash[:danger] = 'El usuario ya se encuentra registrado. Por favor, inicie sesión e inténtelo nuevamente.'
        redirect_to root_path
    else
      if params[:id] 
        @user = Student.where(id: params[:id]).first
      else
        @user = Student.new(user_params)
        if @user.save
          flash[:info] = '¡Usuario registrado!'
        else
          flash[:danger] = @user.errors.full_messages.to_sentence
        end
      end
      record = Record.new
      record.user_id = @user.id
      record.evaluation_id = params[:evaluation_id]
      if record.save
        flash[:success] = "¡Preinscrito extitosamente! Manténgase atento e ingrese a su session de usuario con regularidad. En cuanto su #{record.evaluation.tipo} cuente con el cuorum suficiente se le permitirá descargar la planilla y continuar el proceso de inscripción."
        if current_user and current_user.is_admin?
          redirect_to @user
        else
          session[:user_id] = @user.id
          redirect_to students_session_path
        end
      else
        flash[:danger] = record.errors.full_messages.to_sentence
        redirect_back fallback_location: root_path
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Usuario registrado'
      if current_user and current_user.admin?
        redirect_to @user
      else
        redirect_to root_path
      end
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      if current_user and current_user.admin?
        render :new
      else
        redirect_to root_path
      end
    end
  end

  def record_confirmation
    @record = Record.find params[:record_id]
    @record.baucher = params[:baucher]
    @record.state = :inscrito
    flash[:success] = '¡Inscripción confirmada!' if @record.save
    redirect_back fallback_location: user_path(@record.student)
  end

  def reset_pw
    @user.password = @user.id
    flash[:success] = 'Contraseña reseteada. Ahora será igual a la Cédula de Identidad' if @user.save
    redirect_back fallback_location: user_path(@user)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      flash[:success] = 'Usuario Actualizado'
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
    end
    redirect_to user_path(@user)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      params[:user] = params[:admin] if params[:admin]
      params[:user] = params[:student] if params[:student]
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :last_name, :email, :phone, :password, :password_confirmation)
    end
end
