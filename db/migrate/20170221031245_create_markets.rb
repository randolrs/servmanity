class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :display_name
      t.string :url_name

      t.timestamps null: false
    end
  end
end
