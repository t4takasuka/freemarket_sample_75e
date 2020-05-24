require 'rails_helper'

describe User do
  describe '#create' do
    context 'userを保存できる場合' do
      it "nickname,email,password,password_confirmationがあれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

      it "nicknameが15文字以下であれば登録できること" do
        user = build(:user, nickname: "123456789a12345")
        expect(user).to be_valid
      end

      it "emailにドメインがある場合は登録できないこと" do
        user = build(:user, email: "a@email.com")
        expect(user).to be_valid
      end

      it "passwordが7文字以上の場合は登録できること" do
        user = build(:user, password: "1234567", password_confirmation: "1234567")
        expect(user).to be_valid
      end
    end

    context 'userを保存できない場合' do
      it "nicknameがない場合は登録できないこと" do
        user = build(:user, nickname: "")
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      it "emailがない場合は登録できないこと" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "passwordがない場合は登録できないこと" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "passwordが存在しても、password_confirmationがない場合は登録できないこと" do
        user = build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "nicknameが16文字以上であれば登録できないこと" do
        user = build(:user, nickname: "123456789a123456")
        user.valid?
        expect(user.errors[:nickname]).to include("は15文字以内で入力してください")
      end

      it "重複したemailがある場合は登録できないこと" do
        user = create(:user)
        another_user = build(:user)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "emailにドメインがない場合は登録できないこと" do
        user = build(:user, email: "email")
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
      end

      it "passwordが6文字以下の場合は登録できないこと" do
        user = build(:user, password: "123456", password_confirmation: "123456")
        user.valid?
        expect(user.errors[:password]).to include("は7文字以上で入力してください")
      end

    end
  end
end