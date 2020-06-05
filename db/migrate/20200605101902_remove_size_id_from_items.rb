class RemoveSizeIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :size_id, :integer
  end
end
