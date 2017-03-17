class AddIsLiveToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :is_live, :boolean
  end
end
