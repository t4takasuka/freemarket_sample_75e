class RemovePostageTypeFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :postage_type_id, :integer
  end
end
