class Item < ApplicationRecord
  ### ER図の上から順番に記述
  # belongs_to :brand
  has_many :itemimgs
  accepts_nested_attributes_for :itemimgs, allow_destroy: true
  # has_one :user_evaluation

  # belongs_to_active_hash :size
  # belongs_to_active_hash :item_condition
  # belongs_to_active_hash :postage_payer
  # belongs_to_active_hash :preparation_day
  # belongs_to_active_hash :postage_type # active_hashで良いのか？

  # belongs_to :buyer, class_name: User # ER図なし
  # belongs_to :seller, class_name: User  # ER図なし

  # has_many :favorites,  # 中間テーブルのため記載変更が必要
  # has_many :comments, dependent: :destroy # 中間テーブルのため記載変更が必要
  
  # belongs_to_active_hash :categorie

  ### trello【サーバサイド】商品出品機能の求められる仕様から記述
  # validates :itemimgs, presence: true
  # validates :name, presence: true
  # validates :category, presence: true
  # validates :brand, #任意
  # validates :postage_payer, presence: true
  # validates :prefecture_code, presence: true
  # validates :preparation_day, presence: true  #発送日までの日数について
  # validates :price, presence: true
end
