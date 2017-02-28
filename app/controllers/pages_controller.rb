class PagesController < ApplicationController
  

  def home

    @hide_return_to_home = true
    
    @fixed_bottom_cta = true

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

  

  def about

    @navigation_title = "About"

  end


  
  def our_team

    @navigation_title = "Our Team"

  end

  def how_it_works

    @navigation_title = "How it Works"

  end
 

end
