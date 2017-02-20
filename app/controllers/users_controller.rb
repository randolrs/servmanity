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

      @navigation_title = @user.public_display_name.possessive + " Profile"

  		unless @user
  			redirect_to root_path
  		end
  	else

  		redirect_to root_path
  	end

  end

  def account_settings

    @navigation_title = "Account Settings"
    
  end


end
