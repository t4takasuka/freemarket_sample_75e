class ChangeDatatypeSizeIdOfItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :size_id, :integer
  end
end
