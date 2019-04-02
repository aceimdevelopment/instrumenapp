class StudentsSessionController < ApplicationController
  
  def index
	@user = current_user
	@inscription = Inscription.new
  end

  def evaluation_record

  end
end
