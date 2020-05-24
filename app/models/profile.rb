class Profile < ApplicationRecord
  belongs_to :user, optional: true

  # 全角ひらがな・カタカナ・漢字
    zenkaku = /\A[ぁ-んァ-ン一-龥]+\z/
  # 全角ひらがな
    kana = /\A[ぁ-んー－]+\z/
  
  validates :first_name, :family_name, :first_name_kana, :family_name_kana, :birthday, presence: true
  validates :first_name, format: { with: zenkaku }
  validates :family_name, format: { with: zenkaku }
  validates :first_name_kana, format: { with: kana }
  validates :family_name_kana, format: { with: kana }
end
