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


	def calculated_price

		unless self.is_live

			if self.hours_reported_by_tasker && self.tasker_hourly_rate

				price = self.hours_reported_by_tasker * self.tasker_hourly_rate

				return price

			else

				return nil

			end

		else

			return self.price

		end


	end


	def tasker

		if self.tasker_id

			tasker = User.where(:id => self.tasker_id).last

			if tasker

				return tasker

			else

				return nil

			end

		else

			return nil

		end

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

	def self.has_pending_charge

		return ServiceRequest.where(:is_complete_tasker => true, :charge_approved => nil).where.not(:stripe_customer_id => nil)

	end

	def has_pending_charge

		if (self.is_complete_tasker && self.tasker_completion_time && !self.charge_approved && self.stripe_customer_id)
			return true
		else
			return false
		end
	end

	def time_between_request_and_completion

		if self.tasker_completion_time
			
			raw_difference = (self.tasker_completion_time - self.created_at).to_i

			hours = raw_difference / 3600
			raw_difference -= hours * 3600

			minutes = raw_difference / 60
			raw_difference -= minutes * 60

			seconds = raw_difference

			return hours.to_s + " hours, " + minutes.to_s + " minutes"

		else

			return nil

		end
		
	end

	def service_fee

		if self.price
			

			service_fee_raw = self.price * 0.08

			return service_fee_raw

		end
	end


end
