class UserSessionsController < ApplicationController

  layout 'visitors'
  
  def index
  	@user = current_user
  end

  def evaluation_record

  end
end
