class AddStripeCustomerIdToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :stripe_customer_id, :string
  end
end
