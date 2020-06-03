class AddActiveHashToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items,  :item_condition_id, :integer
    add_column :items, :postage_payer_id, :integer
    add_column :items, :postage_type_id, :integer
    add_column :items, :preparation_day_id, :integer
    add_column :items, :size, :string
  end
end
