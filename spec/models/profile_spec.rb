require 'rails_helper'

describe Profile do
  describe '#create' do
    context 'profileを保存できる場合' do
      it "全て入力してある場合は登録できること" do
        profile = build(:profile)
        expect(profile).to be_valid
      end

      it "family_nameが全角の場合は登録できること" do
        profile = build(:profile, family_name: "田中たなかタナカ")
        expect(profile).to be_valid
      end

      it "first_nameが全角の場合は登録できること" do
        profile = build(:profile, first_name: "次郎じろうジロウ")
        expect(profile).to be_valid
      end

      it "family_name_kanaがひらがなの場合は登録できること" do
        profile = build(:profile, family_name_kana: "たなか")
        expect(profile).to be_valid
      end

      it "first_name_kanaがひらがなの場合は登録できること" do
        profile = build(:profile, family_name_kana: "じろう")
        expect(profile).to be_valid
      end

      it "introductionがない場合でも登録できること" do
        profile = build(:profile, introduction: "")
        expect(profile).to be_valid
      end

      it "avatarがない場合でも登録できること" do
        profile = build(:profile, avatar: "")
        expect(profile).to be_valid
      end
    end

    context 'profileを保存できない場合' do
      it "family_nameがない場合は登録できないこと" do
        profile = build(:profile, family_name: "")
        profile.valid?
        expect(profile.errors[:family_name]).to include("を入力してください")
      end

      it "family_nameが全角ではない場合は登録できないこと" do
        profile = build(:profile, family_name: "111")
        profile.valid?
        expect(profile.errors[:family_name]).to include("は不正な値です")
      end

      it "first_nameがない場合は登録できないこと" do
        profile = build(:profile, first_name: "")
        profile.valid?
        expect(profile.errors[:first_name]).to include("を入力してください")
      end

      it "first_nameが全角ではない場合は登録できないこと" do
        profile = build(:profile, first_name: "aaa")
        profile.valid?
        expect(profile.errors[:first_name]).to include("は不正な値です")
      end

      it "family_name_kanaがない場合は登録できないこと" do
        profile = build(:profile, family_name_kana: "")
        profile.valid?
        expect(profile.errors[:family_name_kana]).to include("を入力してください")
      end

      it "family_name_kanaがひらがなではない場合は登録できないこと" do
        profile = build(:profile, family_name_kana: "田中")
        profile.valid?
        expect(profile.errors[:family_name_kana]).to include("は不正な値です")
      end

      it "first_name_kanaがない場合は登録できないこと" do
        profile = build(:profile, first_name_kana: "")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("を入力してください")
      end

      it "first_name_kanaがひらがなではない場合は登録できないこと" do
        profile = build(:profile, first_name_kana: "ジロウ")
        profile.valid?
        expect(profile.errors[:first_name_kana]).to include("は不正な値です")
      end

      it "birthdayがない場合は登録できないこと" do
        profile = build(:profile, birthday: "")
        profile.valid?
        expect(profile.errors[:birthday]).to include("を入力してください")
      end

    end
  end
end