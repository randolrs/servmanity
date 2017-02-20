class ServiceRequest < ActiveRecord::Base

	belongs_to :service_category
	
	def recommended_taskers

		@users = User.all
		
		return @users

	end
end
