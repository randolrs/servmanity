class ServiceRequest < ActiveRecord::Base

	def recommended_taskers

		@users = User.all
		
		return @users

	end
end
