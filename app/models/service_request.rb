class ServiceRequest < ActiveRecord::Base

	belongs_to :service_category

	belongs_to :user
	
	def recommended_taskers

		@users = User.all
		
		return @users

	end
end
