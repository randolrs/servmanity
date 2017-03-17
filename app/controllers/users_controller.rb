class UsersController < ApplicationController
  
  def non_tasker_signup
  	@hide_header = true
    flash[:message_at_top] = "Signup for Servmanity"
  end

  def tasker_signup
  	@hide_header = true
    flash[:message_at_top] = "Signup for Servmanity"
  end

  def profile

  	if params[:id]

  		@user = User.where(:id => params[:id]).last

  		unless @user
        flash[:error_prompt] = 'Error: Cannot Find Profile'
  			redirect_to root_path

      else

        unless @user.id == current_user.id
          @navigation_title = @user.public_display_name.possessive + " Profile"
        else
          @navigation_title = "Your Profile"
        end

  		end
  	else
      flash[:error_prompt] = 'Error: Cannot Find Profile'
  		redirect_to root_path
  	end

  end

  def account_settings

    @navigation_title = "Account Settings"
    
  end

  def requests

    @navigation_title = "My Requests"

    if user_signed_in?

      if current_user.is_tasker

        @service_requests = current_user.requests_assigned_to_me

      else

        @service_requests = current_user.service_requests

      end

    else

      redirect_to root_path

    end

  end

  def messages

    @navigation_title = "My Messages"

  end

  def live

    @navigation_title = "Live"

    @service_requests = current_user.live_requests_for_tasker


  end


end
