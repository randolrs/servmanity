class CreateUserServiceCategories < ActiveRecord::Migration
  def change
    create_table :user_service_categories do |t|
      t.integer :user_id
      t.integer :service_category_id
      t.text :description
      t.decimal :hourly_rate

      t.timestamps null: false
    end
  end
end
