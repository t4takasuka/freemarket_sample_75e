
FactoryBot.define do
  
  factory :sending_destination do
    destination_family_name              {"山田"}
    destination_first_name               {"太郎"}
    destination_family_name_kana         {"やまだ"}
    destination_first_name_kana          {"たろう"}
    post_code                            {"1234567"}
    prefecture_code                      {"東京都"}
    city                                 {"新宿区1丁目"}
    house_number                         {"1番地"}
    building_name                        {"新宿ビル 101号室"}
    phone_number                         {"12345678901"}
  end

end