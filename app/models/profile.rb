class Profile < ApplicationRecord
  belongs_to :user, optional: true

  # 漢字
    kanji = /\A[一-龥]+\z/
  # 全角カタカナ
    kana = /\A[ァ-ヶー－]+\z/
  
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :birthday, presence: true
  validates :family_name, length: { maximum: 15 }, format: { with: kanji }
  validates :first_name_kana, length: { maximum: 15 }, format: { with: kana }
  validates :family_name_kana, length: { maximum: 15 }, format: { with: kana }
end
