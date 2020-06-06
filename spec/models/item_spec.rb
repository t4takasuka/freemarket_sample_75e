require 'rails_helper'
describe Item do
  describe "#create" do
    context 'itemを保存できる場合' do
      it "全てを入力してあれば登録できること" do
        item = build(:item, :image1)
        expect(item).to be_valid
      end

      it "imagesを10枚まで登録できること" do
        item = build(:item, :image10)
        expect(item).to be_valid
      end
    end

    context 'itemを保存できない場合' do
      it "nameがない場合は登録できないこと" do
        item = build(:item, :image1, name: "")
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "categoryがない場合は登録できないこと" do
        item = build(:item, :image1, category: nil)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

      it "prefecture_codeがない場合は登録できないこと" do
        item = build(:item, :image1, prefecture_code: "")
        item.valid?
        expect(item.errors[:prefecture_code]).to include("を入力してください")
      end

      it "prefecture_codeがない場合は登録できないこと" do
        item = build(:item, :image1, preparation_day_id: "")
        item.valid?
        expect(item.errors[:preparation_day_id]).to include("を入力してください")
      end

      it "priceがない場合は登録できないこと" do
        item = build(:item, :image1, price: "")
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end

      it "item_condition_idがない場合は登録できないこと" do
        item = build(:item, :image1, item_condition_id: "")
        item.valid?
        expect(item.errors[:item_condition_id]).to include("を入力してください")
      end

      it "postage_payer_idがない場合は登録できないこと" do
        item = build(:item, :image1, postage_payer_id: "")
        item.valid?
        expect(item.errors[:postage_payer_id]).to include("を入力してください")
      end

      it "postage_type_idがない場合は登録できないこと" do
        item = build(:item, :image1, postage_type_id: "")
        item.valid?
        expect(item.errors[:postage_type_id]).to include("を入力してください")
      end

      it "seller_idがない場合は登録できないこと" do
        item = build(:item, :image1, seller_id: "")
        item.valid?
        expect(item.errors[:seller_id]).to include("を入力してください")
      end

      it "buyer_idがない場合は登録できないこと" do
        item = build(:item, :image1, buyer_id: "")
        item.valid?
        expect(item.errors[:buyer_id]).to include("を入力してください")
      end

      it "size_idがない場合は登録できないこと" do
        item = build(:item, :image1, size_id: "")
        item.valid?
        expect(item.errors[:size_id]).to include("を入力してください")
      end

      it "imagesがない場合は登録できないこと" do
        item = build(:item)
        item.valid?
        expect(item.errors[:images]).to include("を入力してください")
      end

      it "imagesが11枚以上の場合は登録できないこと" do
        item = build(:item, :image11)
        item.valid?
        expect(item.errors[:images]).to include("は10文字以内で入力してください")
      end
    end
  end
end
