class AddStripeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_account_id, :string
    add_column :users, :stripe_secret_key, :string
    add_column :users, :stripe_publishable_key, :string
  end
end
