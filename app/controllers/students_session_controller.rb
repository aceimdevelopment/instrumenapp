class StudentsSessionController < ApplicationController

  before_action :login_filter
  
  def index
	@user = current_user
	@inscription = Inscription.new
  end

  def evaluation_record

  end
end
