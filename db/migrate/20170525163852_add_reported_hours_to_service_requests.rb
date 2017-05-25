class AddReportedHoursToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :hours_reported_by_tasker, :decimal
  end
end
