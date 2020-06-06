class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.references :category
      t.references :item_size
      t.timestamps
    end
  end
end
