class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  layout 'visitors', only: [:evaluation]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
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


  def record_in_evaluation

    @user = Student.where(id: user_params[:id]).first
    @user = Student.new(user_params) unless @user
    if @user.save
      flash[:success] = 'Usuario registrado'
      if params[:evaluation_id]
        # t = Record.new
        # t.evaluation_id = params[:evaluation_id]
        # t.user_id = @user.id

        if @user.records.create(evaluation_id: params[:evaluation_id]) #t.save
          flash[:success] += ' y preinscrito con éxito.'
          if current_user and current_user.admin?
            redirect_to @user
          else
            session[:user_id] = @user.id
            redirect_to students_session_path
          end
        else
          flash[:danger] = t.errors.full_messages.to_sentence
          redirect_to fallback_location: "#{users_evaluation_path}?id=#{user_params[:id]}"
        end
      end
    else
      flash[:danger] = "Error: #{@user.errors.full_messages.to_sentence}"
      redirect_back fallback_location: "#{users_evaluation_path}?id=#{user_params[:id]}"
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :name, :last_name, :email, :phone, :password, :role, :password_confirmation)
    end
end
