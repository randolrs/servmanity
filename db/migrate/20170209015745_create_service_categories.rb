class CreateServiceCategories < ActiveRecord::Migration
  def change
    create_table :service_categories do |t|
      t.string :name
      t.text :description
      t.string :url_name

      t.timestamps null: false
    end
  end
end
