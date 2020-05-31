class Profile < ApplicationRecord
  belongs_to :user, optional: true

  # 全角ひらがな・カタカナ・漢字
  zenkaku = /\A[ぁ-んァ-ン一-龥]+\z/
  # 全角ひらがな
  kana = /\A[ぁ-んー－]+\z/

  validates :birthday, presence: true
  validates :first_name, format: { with: zenkaku }, allow_blank: true
  validates :first_name, presence: true
  validates :family_name, format: { with: zenkaku }, allow_blank: true
  validates :family_name, presence: true
  validates :first_name_kana, format: { with: kana }, allow_blank: true
  validates :first_name_kana, presence: true
  validates :family_name_kana, format: { with: kana }, allow_blank: true
  validates :family_name_kana, presence: true
end
