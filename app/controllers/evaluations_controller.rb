class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy, :confirm, :qualify]

  before_action :login_filter
  before_action :admin_filter
  
  # GET /evaluations
  # GET /evaluations.json

  def index
    # Evaluation.archive_old_eva
    @evaluation = Evaluation.new
    @evaluation.type = 'Course'

    if params[:type].eql? 'test'
      @inscriptions = Inscription.test.pendents.joins(:user).order('last_name ASC')
      @schedules = Schedule.prueba
      @title = "Pruebas"
      @evaluation.type = 'Test'
      @evaluation.start = Test.next_saturday_test
      @evaluation.cost = GeneralParameter.costo_prueba.value if GeneralParameter.costo_prueba
      @evaluation.schedule_id = GeneralParameter.horario_prueba.value if GeneralParameter.horario_prueba
      @evaluation.location = GeneralParameter.ubicacion_prueba.value if GeneralParameter.ubicacion_prueba
      begin
        Test.check_actives_tests
      rescue Exception => e
        flash[:danger] = 'No se pudo revisar la creación de Pruebas automáticas'
      end

      @schedules = Schedule.where(evatype: 'test')
      @actives = Test.activa

    elsif params[:type].eql? 'course'
      @evaluation.type = 'Course'
      @title = "Cursos"
      @inscriptions = Inscription.course.pendents.joins(:user).order('last_name ASC')
      @actives = Course.activa
      @schedules = Schedule.curso
    else
      @title = "Evaluaciones"
      @actives = Evaluation.activa
      @inscriptions = Inscription.pendents.limit(50)
      @schedules = Schedule.all
    end

  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Evaluation.new
    @evaluation.type = params[:type]
  end

  # GET /evaluations/1/edit
  def edit
  end

  def confirm
    @evaluation.state = :confirmado
    flash[:success] = '¡Confirmado!' if @evaluation.save
    redirect_back fallback_location: evaluations_path
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(evaluation_params)

    if @evaluation.save
      flash[:success] = 'Evaluación creada con éxito.'
      if @evaluation.is_a? Course and params[:areas]
        params[:areas].each do |a|

          area = Area.find a
          area.inscriptions.preinscrito.each do |pr|
            pr.evaluation_id = @evaluation.id
            pr.save
          end

          @evaluation.area_courses.create(area_id: a)
        end
      end
    else
      flash[:danger] = "Error: #{@evaluation.errors.full_messages.to_sentence}"
    end

    redirect_back fallback_location: "#{evaluations_path}?#{@evaluation.type}=true"

  end

  def qualify
    params[:inscriptions].each_pair do |k,v|
      ins = Inscription.find k
      ins.status = v
      ins.save
    end
    @evaluation.status = :archivada if params[:archive]
    @evaluation.save
    redirect_to "#{evaluations_path}?type=#{@evaluation.type.downcase}"
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    if @evaluation.update(evaluation_params)
      flash[:success] = 'Evaluación actualizada con éxito.'
    else
      flash[:danger] =  @evaluation.errors.full_messages.to_sentence
    end

    redirect_back fallback_location: evaluations_path
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.area_courses.delete_all if @evaluation.is_a? Course
    @evaluation.destroy
    flash[:info] = "¡Evaluación Eliminada!"
    redirect_back fallback_location: evaluations_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      # if params[:duration]
      #   a = DateTime.parse params[:evaluation][:start]
      #   params[:evaluation][:end] = (a + params[:duration].to_i.hours).to_s
      # end
      params.require(:evaluation).permit(:start, :title, :location, :type, :schedule_id, :cost, :status)
    end
end
