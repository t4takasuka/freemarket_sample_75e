FactoryBot.define do
  factory :item do
    name                      { "hoge" }
    introduction              { "huga" }
    price                     { 1000 }
    prefecture_code           { "東京都" }
    # ↓active_hashデータ
    preparation_day_id        { 1 }
    item_condition_id         { 1 }
    postage_payer_id          { 1 }
    postage_type_id           { 1 }
    # ↓referenceキー
    category                  { create(:category) }
    seller                    { create(:user) } 
    buyer                     { create(:user, email: "nnn@gmail.com") } #sellerのuserとは違うアドレスで、異なるuserとして設定している
    brand                     { create(:brand) }
    after(:build) do |item|
      item.images << build(:image)
    end

    # バリデーションに記述がなかったもの
    # trading_status            { "出品中" }

  end
end
