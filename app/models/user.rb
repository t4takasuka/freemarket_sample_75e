class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  has_one :card, dependent: :destroy
  has_many :credit_cards, dependent: :destroy
  has_many :seller, class_name: 'Item', foreign_key: 'seller_id'
  has_many :buyer, class_name: 'Item', foreign_key: 'buyer_id'
  has_many :items, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites, through: :favorites, source: :item
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, length: { maximum: 15 }, presence: true
  validates :email, uniqueness: true, allow_blank: true
  validates :email, presence: true
end
