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
    size_id                   { 1 }
    # ↓referenceキー
    category                  { create(:category) }
    seller                    { create(:user) } 
    buyer                     { create(:user, email: "nnn@gmail.com") } #sellerのuserとは違うアドレスで、異なるuserとして設定している
    brand                     { create(:brand) }
    
    # ↓1枚の画像をアップロードする
    trait :image1 do 
      after(:build) do |item|
          item.images << build(:image)
      end
    end

    # ↓10枚の画像をアップロードする
    trait :image10 do 
      after(:build) do |item|
        10.times do
          item.images << build(:image)
        end
      end
    end

    # ↓11枚の画像をアップロードする
    trait :image11 do 
      after(:build) do |item|
        11.times do
          item.images << build(:image)
        end
      end
    end
    
  end
end
