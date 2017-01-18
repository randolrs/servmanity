class AddTaskerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_tasker, :boolean
  end
end
