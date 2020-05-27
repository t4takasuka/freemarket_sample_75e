class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_one :sending_destination, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, length: { maximum: 15 }, presence: true
  validates :email, uniqueness: true, allow_blank: true
end
