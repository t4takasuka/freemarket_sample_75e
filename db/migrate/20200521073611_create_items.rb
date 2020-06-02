class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      ### ER図の通り上から順番に記入している。
      t.string :name,                 null: false
      t.text :introduction,           null: false
      t.integer :price,               null: false
      t.references :brand,                         foreign_key: true
      t.integer :prefecture_code,     null: false 
      t.references :category,         null: false,foreign_key: true
      t.integer :trading_status,      null: false, default: 0
      t.references :seller,           null: false, foreign_key: { to_table: :users}
      t.references :buyer,            null: false, foreign_key: { to_table: :users}
      t.timestamps :deal_closed_data
    end
  end
end

