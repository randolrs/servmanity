class AddAttachmentImageToServiceCategories < ActiveRecord::Migration
  def self.up
    change_table :service_categories do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :service_categories, :image
  end
end
