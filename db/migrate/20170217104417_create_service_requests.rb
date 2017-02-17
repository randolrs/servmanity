class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.integer :user_id
      t.integer :service_category_id
      t.string :address
      t.float :longitude
      t.float :latitude
      t.text :additional_information
      t.datetime :scheduled_date

      t.timestamps null: false
    end
  end
end
