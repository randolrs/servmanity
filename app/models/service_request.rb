class ServiceRequest < ActiveRecord::Base

	belongs_to :service_category

	belongs_to :user
	
	def recommended_taskers

		service_category = ServiceCategory.find(self.service_category_id)

		taskers_for_this_category = service_category.users
		
		return taskers_for_this_category
	end

	def status

		if self.tasker_id

			if self.is_complete_tasker

				return "Complete"
				
			else

				return "Scheduled"

			end
		else

			return "Need to Select Professional"

		end


	end
end
