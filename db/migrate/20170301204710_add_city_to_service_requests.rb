class AddCityToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :city, :string
  end
end
