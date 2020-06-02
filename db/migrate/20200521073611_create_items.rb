class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      ### ER図の通り上から順番に記入している。
      t.string :name,                 null: false
      # t.text :introduction,           null: false
      t.integer :price,               null: false
      # t.references :brand,                         foreign_key: true
      # t.references :item_condition,   null: false, foreign_key: true
      # t.references :postage_payer,    null: false, foreign_key: true
      # t.integer :prefecture_code,     null: false #ER図なし。item_modelで定義する。
      # t.references :size,             null: false, foreign_key: true
      # t.references :preparation_day,  null: false, foreign_key: true
      # t.references :category,         null: false, foreign_key: true
      # t.integer :trading_status,      null: false #ER図なし。item_modelで定義する。
      t.integer :seller_id
      t.integer :buyer_id
      # t.timestamps :deal_closed_data
    end
  end
end
