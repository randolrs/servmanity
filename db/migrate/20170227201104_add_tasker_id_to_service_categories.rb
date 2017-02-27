class AddTaskerIdToServiceCategories < ActiveRecord::Migration
  def change
    add_column :service_categories, :tasker_id, :integer
  end
end
