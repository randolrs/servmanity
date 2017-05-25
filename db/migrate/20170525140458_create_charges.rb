class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :tasker_id
      t.decimal :amount
      t.string :stripe_customer_id
      t.string :destination_stripe_account_id
      t.decimal :service_fee

      t.timestamps null: false
    end
  end
end
