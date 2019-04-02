class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy, :confirm]

  # GET /evaluations
  # GET /evaluations.json
  def archive_old_test
    Evaluation.activa.where("start < #{Date.today}").each do |a| 
      a.status = :archivada 
      a.save
    end
  end

  def index
    if params[:type].eql? 'test'
      @inscriptions = Inscription.test.pendents
      @schedules = Schedule.prueba
      @title = "Pruebas"

      archive_old_test

      next_testday = Inscription.next_saturday_testday
      
      @actives = Test.activa.where("start > #{next_testday}")

      if @actives.count < 1
        @test = Test.new
        cost = GeneralParameter.costo_prueba.value
        schedule = GeneralParameter.horario_prueba.value
        location = GeneralParameter.ubicacion_prueba

        @test.start = next_testday
        @test.cost = cost
        @test.schedule_id = schedule
        @test.location = location

        @test.save
      end
      @actives = Test.activa.where(start: next_testday)
      # @evaluation = Evaluation.find 1 #@actives.first.id

    elsif params[:type].eql? 'course'
      @title = "Cursos"
      @inscriptions = Inscription.course.pendents
      @actives = Course.activa
      @schedules = Schedule.curso
    else
      @title = "Evaluaciones"
      @actives = Evaluation.activa
      @inscriptions = Inscription.pendents.limit(50)
      @schedules = Schedule.all
    end
    # @evaluation = Evaluation.new
    @evaluation = Evaluation.first# 1 #@actives.first.id


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
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to evaluations_path, notice: 'Evaluación creada con éxito.' }
        format.json { render :show, status: :created, location: @evaluation }
      else
        flash[:danger] =  @evaluation.errors.full_messages.to_sentence
        format.html { redirect_to evaluations_path}
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
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
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Evaluación eliminda con éxito.' }
      format.json { head :no_content }
    end
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
      params.require(:evaluation).permit(:start, :title, :location, :type, :schedule, :cost, :status)
    end
end
