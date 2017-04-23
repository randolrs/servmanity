class AddPriceToServiceRequest < ActiveRecord::Migration
  def change
    add_column :service_requests, :price, :decimal
  end
end
