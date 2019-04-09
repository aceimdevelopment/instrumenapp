class InscriptionsController < ApplicationController
  before_action :set_inscription, only: [:show, :edit, :update, :destroy, :update_evaluation]
  layout 'visitors', only: [:new]


  before_action :login_filter
  
  # GET /inscriptions
  # GET /inscriptions.json
  def index
    @inscriptions = Inscription.all
  end

  # GET /inscriptions/1
  # GET /inscriptions/1.json
  def show
  end

  # GET /inscriptions/new
  def new
    @inscription = Inscription.new

    if params[:user_id]
      @user = Student.where(id: params[:user_id]).first
      @is_new = false
    else
      @user = Student.new
      @is_new = true
    end

    if params[:course]
      @languages = Language.where(id: 'ING')
      @eva_title = 'Cursos'
      @inscription.evatype = :course
    else #params[:test]
      @languages = Language.all.order(description: :asc)
      @eva_title = 'Pruebas'
      @inscription.evatype = :test
    end
    @areas = Area.all.order(description: :asc)

  end

  # GET /inscriptions/1/edit
  def edit
  end

  def confirmation
    @inscription = Inscription.find params[:inscription_id]
    @inscription.baucher = params[:baucher]
    @inscription.status = :inscrito
    @inscription.evaluation_id = params[:evaluation_id]
    if @inscription.save
      flash[:success] = '¡Inscripción confirmada!'
    else
      flash[:error] = "Error: #{@inscription.erros.full_messages.to_sencentes}"
    end


    redirect_back fallback_location: user_path(@inscription.user)
  end

  # POST /inscriptions
  # POST /inscriptions.json
  def create
    have_user = true
    have_inscription = false

    @student = Student.find_or_initialize_by(id: params[:user][:id])

    @student.name = params[:user][:name]
    @student.last_name = params[:user][:last_name]
    @student.email = params[:user][:email]
    @student.phone = params[:user][:phone]

    if true #@student.new_record?
      @student.password = params[:user][:password]
      @student.password_confirmation = params[:user][:password_confirmation]
    end

    unless @student.save
      flash[:danger] = "No fue posible registrar al estudiante: #{@student.errors.full_messages.to_sentence}"
      have_user = false
    end

    if have_user
      @inscription = Inscription.new(inscription_params)
      @inscription.user_id = @student.id if @student

      if @inscription.save
        have_inscription = true
        if @inscription.course?
          flash[:success] = "¡Preinscrito exitosamente! Manténgase atento e ingrese a su session de usuario con regularidad. En cuanto su curso cuente con el quorum suficiente se le informará y se le permitirá descargar la planilla para continuar el proceso de inscripción."
        else
          flash[:success] = "¡Preinscrito exitosamente! Descargue <a target='_blank' href='/download/#{@inscription.id}/make_inscription' ><i class='fa fa-download'></i>
aquí</a> su planilla de preinscripción."
        end 

      else
        flash[:danger] = "No fue posible registrar al estudiante: #{@inscription.errors.full_messages.to_sentence}"
      end
    end


    if have_inscription

        if current_user and current_user.is_admin?
          redirect_to user_path @inscription.user.id
        else
          session[:user_id] = @inscription.user.id
          redirect_to students_session_path
        end
    else
      redirect_back fallback_location: root_path
    end


  end

  # PATCH/PUT /inscriptions/1
  # PATCH/PUT /inscriptions/1.json
  def update_evaluation
    @inscription.evaluation_id = params[:evaluation_id]
    if @inscription.save
      flash[:success] = "Actualizada Inscripción"
    else
      flash[:danger] = "#{@inscription.erros.full_messages.to_sentence}"
    end
    redirect_back fallback_location: "#{evaluations_path}?type=test"
  end

  def update
    respond_to do |format|
      if @inscription.update(inscription_params)
        format.html { redirect_to @inscription, notice: 'Inscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @inscription }
      else
        format.html { render :edit }
        format.json { render json: @inscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscriptions/1
  # DELETE /inscriptions/1.json
  def destroy
    @inscription.destroy
    flash[:info] = 'Inscripción eliminada con éxito!'
    redirect_back fallback_location: "#{evaluations_path}?type=test"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inscription
      @inscription = Inscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inscription_params
      # params.require(:user).permit!
      # params.require(:user).permit(:id, :name, :last_name, :email, :phone, :password, :password_confirmation)

      # params.require(:user).permit!#(:language_id, :area_id, :user_id, :evaluation_id, :status, :score, :baucher, :evatype)
      params.require(:inscription).permit(:language_id, :area_id, :user_id, :evaluation_id, :status, :score, :baucher, :evatype)
    end
end
