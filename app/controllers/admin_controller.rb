class AdminController < ApplicationController
  
	def admin_home

	end

	def admin_users

	end


	def admin_service_requests

	end


	def admin_charges

	end

	def edit_user
		@user = User.find(params[:id])
	end


end
