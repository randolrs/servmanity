class UserServiceCategory < ActiveRecord::Base
	belongs_to :user
	belongs_to :service_category
end
