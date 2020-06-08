class AddItemSizeIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_size_id, :integer
  end
end
