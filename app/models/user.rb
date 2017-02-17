class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	has_attached_file :image, 
		:styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
		:default_url => 'missing_person_photo.png',
		:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :user_service_categories
	has_many :service_categories, :through => :user_service_categories


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

end
