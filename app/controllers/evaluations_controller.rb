class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]

  # GET /evaluations
  # GET /evaluations.json
  def index
      @tests = Test.all.limit(50)
      @courses = Course.all.limit(50)
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

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = Evaluation.new(evaluation_params)
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to evaluations_path, notice: 'Evaluation creada con éxito.' }
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
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to evaluations_path, notice: 'Evaluation actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        flash[:danger] =  @evaluation.errors.full_messages.to_sentence
        format.html { redirect_to evaluations_path}
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Prueba eliminda con éxito.' }
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
      if params[:duration]
        a = DateTime.parse params[:evaluation][:start]
        params[:evaluation][:end] = (a + params[:duration].to_i.hours).to_s
      end
      params.require(:evaluation).permit(:start, :end, :location, :language_id, :type, :area_id)
    end
end
