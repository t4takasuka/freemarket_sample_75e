class User < ApplicationRecord
  has_one :profile
  has_one :sending_destination
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, length: { maximum: 15 }, presence: true
  validates :email, presence: true, uniqueness: true
end
