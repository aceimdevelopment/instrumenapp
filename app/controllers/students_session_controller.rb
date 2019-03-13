class StudentsSessionController < ApplicationController
  
  def index
  	@user = current_user
  end

  def evaluation_record

  end
end
