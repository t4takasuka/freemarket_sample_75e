require 'rails_helper'

describe SendingDestination do
  describe '#create' do
    context 'sending_destinationを保存できる場合' do
      it "全て入力済みである場合は登録できること" do
        sending_destination = build(:sending_destination)
        expect(sending_destination).to be_valid
      end
      it "destination_family_nameが全角の場合は登録できること" do
        sending_destination = build(:sending_destination, destination_family_name: "田中たなかタナカ")
        expect(sending_destination).to be_valid
      end

      it "destination_first_nameが全角の場合は登録できること" do
        sending_destination = build(:sending_destination, destination_first_name: "次郎じろうジロウ")
        expect(sending_destination).to be_valid
      end

      it "destination_family_name_kanaがひらがなの場合は登録できること" do
        sending_destination = build(:sending_destination, destination_family_name_kana: "たなか")
        expect(sending_destination).to be_valid
      end

      it "destination_first_name_kanaがひらがなの場合は登録できること" do
        sending_destination = build(:sending_destination, destination_family_name_kana: "じろう")
        expect(sending_destination).to be_valid
      end

      it "phone_numberが10文字の数字の場合は登録できること" do
        sending_destination = build(:sending_destination, phone_number: "1234567890")
        expect(sending_destination).to be_valid
      end

      it "phone_numberが11文字の数字の場合は登録できること" do
        sending_destination = build(:sending_destination, phone_number: "12345678901")
        expect(sending_destination).to be_valid
      end
    end

    context 'sending_destinationを保存できない場合' do
      it "destination_family_nameが全角ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_family_name: "111")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_family_name]).to include("は不正な値です")
      end

      it "destination_first_nameがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_first_name: "")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_first_name]).to include("を入力してください")
      end

      it "destination_first_nameが全角ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_first_name: "aaa")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_first_name]).to include("は不正な値です")
      end

      it "destination_family_name_kanaがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_family_name_kana: "")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_family_name_kana]).to include("を入力してください")
      end

      it "destination_family_name_kanaがひらがなではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_family_name_kana: "田中")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_family_name_kana]).to include("は不正な値です")
      end

      it "destination_first_name_kanaがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_first_name_kana: "")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_first_name_kana]).to include("を入力してください")
      end

      it "destination_first_name_kanaがひらがなではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, destination_first_name_kana: "ジロウ")
        sending_destination.valid?
        expect(sending_destination.errors[:destination_first_name_kana]).to include("は不正な値です")
      end

      it "phone_numberがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("を入力してください")
      end

      it "phone_numberが半角数字ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "aaaaaaa")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("は不正な値です")
      end

      it "phone_numberが7文字ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "12345678")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("は不正な値です")
      end

      it "prefecture_codeがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, prefecture_code: "")
        sending_destination.valid?
        expect(sending_destination.errors[:prefecture_code]).to include("を入力してください")
      end

      it "cityがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, city: "")
        sending_destination.valid?
        expect(sending_destination.errors[:city]).to include("を入力してください")
      end

      it "house_numberがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, house_number: "")
        sending_destination.valid?
        expect(sending_destination.errors[:house_number]).to include("を入力してください")
      end

      it "phone_numberがない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("を入力してください")
      end

      it "phone_numberが半角数字ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "aaaaaaaaaaa")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("は不正な値です")
      end

      it "phone_numberが10か11文字の半角数字ではない場合は登録できないこと" do
        sending_destination = build(:sending_destination, phone_number: "123456789")
        sending_destination.valid?
        expect(sending_destination.errors[:phone_number]).to include("は不正な値です")
      end

      it "重複したphone_numberがある場合は登録できないこと" do
        sending_destination = create(:sending_destination, phone_number: "1234567890")
        another_sending_destination = build(:sending_destination, phone_number: "1234567890")
        another_sending_destination.valid?
        expect(another_sending_destination.errors[:phone_number]).to include("はすでに存在します")
      end
    end
  end
end
