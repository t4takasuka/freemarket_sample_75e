class AddAncestryToItemSize < ActiveRecord::Migration[5.2]
  def change
    add_column :item_sizes, :ancestry, :string
    add_index :item_sizes, :ancestry
  end
end
