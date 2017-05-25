class AddTaskCompletionTimeToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :tasker_completion_time, :datetime
  end
end
