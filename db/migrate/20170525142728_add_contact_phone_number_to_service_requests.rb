class AddContactPhoneNumberToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :contact_phone_number, :string
  end
end
