class AddParentidToServiceCategories < ActiveRecord::Migration
  def change
    add_column :service_categories, :parent_category_id, :integer
  end
end
