class UsersController < ApplicationController
  
  def non_tasker_signup
  	@hide_header = true
  end

  def tasker_signup
  	@hide_header = true
  end

  def profile

  	if params[:id]

  		@user = User.where(:id => params[:id]).last

  		unless @user
  			redirect_to root_path
  		end
  	else

  		redirect_to root_path
  	end

  end


end
