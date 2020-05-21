class Profile < ApplicationRecord
  belongs_to :user, optional: true

  # 漢字
    kanji = /\A[一-龥]+\z/
  # 全角ひらがな、カタカナ
    kana = /\A[ぁ-んァ-ヶー－]+\z/
  
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :birth_year, :birth_month, :birth_day, presence: true
  validates :family_name, length: { maximum: 15 }, format: { with: kanji }
  validates :first_name_kana, length: { maximum: 15 }, format: { with: kana }
  validates :family_name_kana, length: { maximum: 15 }, format: { with: kana }

end
