FactoryBot.define do
  factory :profile do
    family_name              { "山田" }
    first_name               { "太郎" }
    family_name_kana         { "やまだ" }
    first_name_kana          { "たろう" }
    birthday                 { "2020-01-01" }
    introduction             { "こんにちは" }
    avatar                   { "" }
  end
end
