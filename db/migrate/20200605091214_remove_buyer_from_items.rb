class RemoveBuyerFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :buyer
  end
end
