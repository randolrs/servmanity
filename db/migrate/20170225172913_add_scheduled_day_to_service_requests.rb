class AddScheduledDayToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :scheduled_day, :date
  end
end
