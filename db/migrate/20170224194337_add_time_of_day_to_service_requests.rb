class AddTimeOfDayToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :time_of_day, :string
  end
end
