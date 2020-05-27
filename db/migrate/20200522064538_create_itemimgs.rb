class CreateItemimgs < ActiveRecord::Migration[5.2]
  def change
    create_table :itemimgs do |t|
      t.string :image, null: false
      t.references :item, null: false, foreign_key: true
    end
  end
end
