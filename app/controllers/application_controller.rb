class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	before_action :set_last_seen_at, if: proc { user_signed_in? }


	def after_sign_in_path_for(user)

		unless current_user.id
			
			root_path

		else

			root_path
			
		end



	end


	def after_sign_out_path_for(user)

		root_path

	end


	def configure_permitted_parameters

		registration_params = [:email, :password, :first_name, :last_name, :zip_code, :phone_number, :is_tasker, :image]
		devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
		devise_parameter_sanitizer.permit(:sign_in, keys: registration_params)
		devise_parameter_sanitizer.permit(:account_update, keys: registration_params)

	end

	private
		def set_last_seen_at
		  current_user.update_attribute(:last_seen_at, Time.now)
		end


end
