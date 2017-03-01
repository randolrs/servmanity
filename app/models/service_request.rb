class ServiceRequest < ActiveRecord::Base

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	
	reverse_geocoded_by :latitude, :longitude do |obj, results|

		if geo = results.first

			obj.city = geo.city

		end

	end

	after_validation :reverse_geocode



	belongs_to :service_category

	belongs_to :user
	
	def recommended_taskers

		nearby_array = Array.new

		service_category = ServiceCategory.find(self.service_category_id)

		taskers_for_this_category = service_category.users

		nearby_taskers = taskers_for_this_category.near(self.address, 20, :order => "distance")
		
		nearby_taskers.each do |tasker|

			nearby_array << tasker
		end

		return nearby_array
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
