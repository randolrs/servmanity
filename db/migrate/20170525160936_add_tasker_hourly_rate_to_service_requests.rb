class AddTaskerHourlyRateToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :tasker_hourly_rate, :decimal
  end
end
