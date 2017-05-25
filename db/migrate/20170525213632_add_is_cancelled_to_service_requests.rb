class AddIsCancelledToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :is_cancelled, :boolean
  end
end
