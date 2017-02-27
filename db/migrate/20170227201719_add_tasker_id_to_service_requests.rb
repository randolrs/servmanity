class AddTaskerIdToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :tasker_id, :integer
  end
end
