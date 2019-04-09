class GeneralParametersController < ApplicationController

  before_action :login_filter
  before_action :admin_filter

  def index
    @gen_params = GeneralParameter.all#.reject{|obj| obj.id.eql? 'HORARIO_PRUEBA'}
  end

  def set_value

    @param = GeneralParameter.find params[:id]
    params[:value] = params[:schedule][:value] if params[:schedule]

    @param.value = params[:value]
    if @param.save
      flash[:success] = "Valor actualizado"
    else
      flash[:error] = @param.errors.full_message.to_sentence
    end

    redirect_back fallback_location: general_parameters_path
  end

end
