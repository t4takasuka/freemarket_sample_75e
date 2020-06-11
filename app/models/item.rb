class Item < ApplicationRecord
  belongs_to :item_size, optional: true
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :seller,   class_name: 'User'
  belongs_to :buyer, class_name: 'User', optional: true
  has_many :images, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorites, through: :favorites, source: :user
  accepts_nested_attributes_for :images, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  
  enum trading_status: {
    出品中: 0, 売り切れ: 1 
  }

  enum prefecture_code: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
    沖縄県: 47
  }
  
  ### trello【サーバサイド】商品出品機能の求められる仕様から記述
  validates :images, presence: true
  validates :images, length: { minimum: 1, maximum: 10 }, allow_blank: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 1_000_000 }, allow_blank: true
  validates :prefecture_code, presence: true
  validates :category, presence: true
  validates :trading_status, presence: true
  validates :seller_id, presence: true
  validates :item_condition_id, presence: true
  validates :postage_payer_id, presence: true
  validates :preparation_day_id, presence: true 
end
