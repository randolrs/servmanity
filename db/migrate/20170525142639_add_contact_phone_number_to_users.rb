class AddContactPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_phone_number, :string
  end
end
