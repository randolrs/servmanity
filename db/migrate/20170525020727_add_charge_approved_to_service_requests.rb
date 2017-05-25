class AddChargeApprovedToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :charge_approved, :boolean
  end
end
