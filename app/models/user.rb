class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	
  	has_many :user_stripe_customers

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?


	reverse_geocoded_by :latitude, :longitude do |obj, results|

		if geo = results.first

			obj.city = geo.city

		end

	end

	after_validation :reverse_geocode
	



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_attached_file :image, 
		:styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
		:default_url => 'missing_person_photo.png',
		:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :user_service_categories
	has_many :service_categories, :through => :user_service_categories
	has_many :service_requests


	def member_since_string

		year = self.created_at.strftime("%Y")

		if Time.now.strftime("%Y") == year

			string = "since " + self.created_at.strftime("%B")
			
		else

			string = "since " + self.created_at.strftime("%Y")

		end

		return string

	end

	def last_seen_at_string



	end

	def distance_to_destination(destination_latitude, destination_longitude)

		my_latitude = self.latitude
		my_longtidue = self.longitude

		r = 6378137

		dLat = (destination_latitude - my_latitude)* Math::PI / 180
		dLong = (destination_longitude - my_longtidue)* Math::PI / 180

		a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
		    Math.cos(my_latitude * Math::PI / 180) * Math.cos(destination_latitude * Math::PI / 180) *
		    Math.sin(dLong / 2) * Math.sin(dLong / 2);


		c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		d = r * c

		d = d * 0.000621371192 #convert to miles

		return d

	end





	def live_requests_for_tasker

		@begin_time = Time.now - 30.minutes
		@end_time = Time.now

		@current_requests =  ServiceRequest.all.where(:is_live => true, :created_at => @begin_time..@end_time, :tasker_id => nil)

		requests = []
		@current_requests.all.each { |request| requests << request if self.distance_to_destination(request.latitude, request.longitude) < 35 }




	end

	def active_task_for_tasker

		return ServiceRequest.all.where(:is_complete_tasker => nil, :tasker_id => self.id, :is_live => true).last

	end

	def active_task_for_non_tasker

		return ServiceRequest.all.where(:is_complete_tasker => nil, :user_id => self.id, :is_live => true).last

	end


	def outstanding_live_requests


		return self.service_requests.where(:is_live => true)
		
	end


	def has_tasker_basics

		return self.address.present?

	end

	def public_display_name

		@public_display_name = self.first_name + " " + self.last_name.first(1) + "."

		return @public_display_name
	end

	def default_dashboard

		if self.is_tasker

			if self.requests_assigned_to_me.count > 0
				
				return false
			
			else
				
				return true

			end

		else

			if self.service_requests.count > 0
				return false
			else
				return true
			end

		end

	end

	def requests_assigned_to_me

		return ServiceRequest.where(:tasker_id => self.id)

	end

	def hourly_rate_for_category(category_id)

		record = UserServiceCategory.where(:user_id => self.id, :service_category_id => category_id).last

		return record.hourly_rate

	end

	def qualifications_for_category(category_id)

		record = UserServiceCategory.where(:user_id => self.id, :service_category_id => category_id).last

		return record.description

	end



	def stripe_customer_object

	    if UserStripeCustomer.exists?(:user_id => self.id)
	    
	      stripe_customer_id = UserStripeCustomer.where(:user_id => self.id).last.stripe_customer_id

	      return Stripe::Customer.retrieve(stripe_customer_id)

	    else

	      return nil

	    end 
	
	end

	def stripe_account_object

	    if self.stripe_account_id

	      return Stripe::Account.retrieve(self.stripe_account_id)

	    else

	      return nil

    	end

    end


	def stripe_balance

	  if self.stripe_secret_key

	    Stripe.api_key = self.stripe_secret_key

	    balance_object = Stripe::Balance.retrieve()

	    @user_stripe_balance = (balance_object.available[0]['amount'] + balance_object.pending[0]['amount']) / 100

	    if Rails.env == "production"

			Stripe.api_key = ENV['STRIPE_LIVE_SECRET_KEY']

		else

			Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

		end

	    return @user_stripe_balance

	  else

	    return 0

	  end

	end


	# def hourly_rate_for_category(service_category_id)

	# 	category = ServiceCategory.find(service_category_id)

	# 	if category


	# 		user_service_category = UserServiceCategory.where(:user_id => self.id, :service_category_id => service_category_id).last

	# 		if user_service_category

	# 			return user_service_category.hourly_rate
	# 		else

	# 			return nil
	# 		end
	# 	else

	# 		return nil

	# 	end


		

	# end


end
