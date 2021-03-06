class PagesController < ApplicationController
  

  def home

    @hide_return_to_home = true
    
    #@city = request.location.city

    if params[:professional]

      @tasker_view = true

    end

    @fixed_bottom_cta = true

    if user_signed_in?

      if current_user.is_tasker

        unless current_user.image.present?

          redirect_to add_profile_photo_path

        else

          @service_requests = current_user.requests_assigned_to_me

        end

        

      else

        @service_requests = current_user.service_requests

      end

    end



    if user_signed_in?

      
      if current_user.default_dashboard

        @default_dashboard = true
        @top_of_page_message = "Welcome to Servmanity, " + current_user.first_name + "."


      else

        @message_cta = "Please update your profile before being matched."
       
      end
      
    end

  end

  def login

  	@hide_header = true
    flash[:message_at_top] = "Login to your Servmanity account"

  end


  def signup

  	@hide_header = true
  	
  end



  def privacy_policy

    @navigation_title = "Privacy Policy"

  end


  def terms_of_service

    @navigation_title = "Terms of Service"

  end

  def about

    @navigation_title = "About"

  end

  def tasker_home


  end

  
  def our_team

    @navigation_title = "Our Team"

  end

  def how_it_works

    @navigation_title = "How it Works"

  end
 

end
