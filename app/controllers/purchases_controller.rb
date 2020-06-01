class PurchasesController < ApplicationController
  require 'payjp'
  
  before_action :set_card, :set_item
  before_action :set_api_key
  
  def index
    if @card.blank?
      flash[:alert] = '購入前にクレジットカードを登録してください'
      redirect_to controller: "cards", action: "new"
    else
      set_customer
      set_card_information
    end
  end

  def pay
    Payjp::Charge.create(
      amount: @item.price, #支払金額を引っ張ってくる
      customer: @card.customer_id,  #顧客ID
      currency: 'jpy',              #日本円
    )
    redirect_to '/'
  end

  def done
  end

  private

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_PRIVATE_KEY]
  end

  def set_customer # 保管した顧客IDでpayjpから情報取得
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_information # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @card_information = @customer.cards.retrieve(@card.card_id)
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:item_:id])
    # @address = Address.find_by(user_id:current_user.id)
  end

end
