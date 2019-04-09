class AdminsSessionController < ApplicationController

  before_action :login_filter
  before_action :admin_filter
  
  def index
  	@user = current_user
  end

end
