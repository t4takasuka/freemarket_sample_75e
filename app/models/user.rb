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
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname, length: { maximum: 15 }, presence: true
  validates :email, uniqueness: true, allow_blank: true
  validates :email, presence: true

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

end
