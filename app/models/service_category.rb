class ServiceCategory < ActiveRecord::Base

	has_attached_file :image, 
		:styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
		:default_url => 'missing_person_photo.png',
		:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :user_service_categories
	has_many :users, :through => :user_service_categories
end
