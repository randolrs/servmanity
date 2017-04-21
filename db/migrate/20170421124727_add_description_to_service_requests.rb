class AddDescriptionToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :description, :text
  end
end
