class AddActiveToUserStripeCustomers < ActiveRecord::Migration
  def change
    add_column :user_stripe_customers, :default_payment, :boolean
    add_column :user_stripe_customers, :hidden_from_user, :boolean
  end
end
