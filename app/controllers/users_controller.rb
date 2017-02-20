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
        flash[:error_prompt] = 'Error: Cannot Find Profile'
  			redirect_to root_path

      else

        @navigation_title = @user.public_display_name.possessive + " Profile"

  		end
  	else
      flash[:error_prompt] = 'Error: Cannot Find Profile'
  		redirect_to root_path
  	end

  end

  def account_settings

    @navigation_title = "Account Settings"
    
  end


end
