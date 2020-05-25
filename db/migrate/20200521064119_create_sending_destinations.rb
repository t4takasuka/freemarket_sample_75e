class CreateSendingDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :sending_destinations do |t|
      t.string :destination_first_name,       null: false
      t.string :destination_family_name,      null: false
      t.string :destination_first_name_kana,  null: false
      t.string :destination_family_name_kana, null: false
      t.integer :post_code,                   null: false
      t.integer :prefecture_code,              null: false, default: 0
      t.string :city,                         null: false
      t.string :house_number,                 null: false
      t.string :building_name
      t.string :phone_number,                null: false
      t.references :user,                     foreign_key: true
      t.timestamps
    end
    add_index :sending_destinations, :phone_number, unique: true
  end
end
