class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  before_action :login_filter
  before_action :admin_filter

  # GET /schedules
  # GET /schedules.json
  def index
    @title = 'Horarios'
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      flash[:info] = '¡Horario generado con éxito!'
    else
      flash[:error] = @schedule.errors.full_messages.to_sentences
    end

    redirect_back fallback_location: schedules_path
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    if @schedule.update(schedule_params)
      flash[:info] = '¡Horario actualizado con éxito!'
    else
      flash[:error] = @schedule.errors.full_messages.to_sentences
    end

    redirect_back fallback_location: schedules_path

  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:description, :evatype)
    end
end
