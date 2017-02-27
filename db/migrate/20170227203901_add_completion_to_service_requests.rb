class AddCompletionToServiceRequests < ActiveRecord::Migration
  def change
    add_column :service_requests, :is_complete_tasker, :boolean
    add_column :service_requests, :is_complete_user, :boolean
  end
end
