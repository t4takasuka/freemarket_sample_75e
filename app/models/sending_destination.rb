class SendingDestination < ApplicationRecord
  belongs_to :user, optional: true

  # 漢字
    kanji = /\A[一-龥]+\z/
  # 全角ひらがな、カタカナ
    kana = /\A[ぁ-んァ-ヶー－]+\z/
  # 郵便番号（ハイフンなし7桁）
    postal = /\A\d{7}\z/
  # 携帯番号(ハイフンなし10桁or11桁)
    phone = /\A\d{10,11}\z/

  validates :destination_first_name, :destination_family_name, :destination_first_name_kana, :destination_family_name_kana, :post_code, :prefecture_code, :city, :house_number, :phone_number, presence: true
  validates :destination_family_name, length: { maximum: 15 }, format: { with: kanji }
  validates :destination_first_name_kana, length: { maximum: 15 }, format: { with: kana }
  validates :destination_family_name_kana, length: { maximum: 15 }, format: { with: kana }
  validates :post_code, format: { with: postal }
  validates :phone_number, uniqueness: true, format: { with: phone }
end
