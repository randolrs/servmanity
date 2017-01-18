class UsersController < ApplicationController
  
  def non_tasker_signup
  	@hide_header = true
  end

  def tasker_signup
  	@hide_header = true
  end
end
