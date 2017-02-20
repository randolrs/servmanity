class PagesController < ApplicationController
  

  def home

    @hide_return_to_home = true
  end

  def login

  	@hide_header = true

  end


  def signup

  	@hide_header = true
  	
  end

  

  def about


  end


  
  def our_team


  end

 

end
