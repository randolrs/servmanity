class PagesController < ApplicationController
  

  def home

    @hide_return_to_home = true
    
    if user_signed_in?
      @message_cta = "Please update your profile before being matched."
      @top_of_page_message = "Welcome to Servmanity, " + current_user.first_name + "."
    end

  end

  def login

  	@hide_header = true

  end


  def signup

  	@hide_header = true
  	
  end

  

  def about

    navigation_title = "About Servmanity"

  end


  
  def our_team

    navigation_title = "Our Team"

  end

  def how_it_works

    navigation_title = "How it Works"

  end
 

end
