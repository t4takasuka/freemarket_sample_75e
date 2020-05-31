class CardsController < ApplicationController
  require 'payjp'

  # before_action :set_item, only:[:show, :pay]
  before_action :take_card, only:[:show, :pay, :destroy]
  before_action :set_api_key

  def new
    @card = Card.where(user_id: current_user.id)
  end

  def create
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      user_id = current_user.id
      customer = Payjp::Customer.create(
      card: params['payjp-token']
      ) 
      @card = Card.new(user_id: user_id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        flash[:notice] = '登録しました'
        redirect_to "/"
      else
        flash[:alert] = '登録できませんでした'
        redirect_to action: "new"
      end
    end
  end

  def show 
    if @card.blank?
      flash[:alert] = '購入前にクレジットカードを登録してください'
      redirect_to action: "new"
    else
      set_customer
      set_card_information
    end
    # if current_user.address == nil
    #   flash[:alert] = '購入前に住所登録してください'
    #   redirect_to new_address_path
    # end
  end

  def destroy
    if @card.blank?
    else
      flash[:alert] = 'クレジットカードを削除しました'
      set_customer
      @customer.delete
      @card.delete
    end
    redirect_to action: "new"
  end

  def pay
    # @item.update(buyer_id: current_user.id)
    # 現在のユーザーを購入者に登録
    Payjp::Charge.create(
    amount: @item.price, 
    customer: @card.customer_id, 
    currency: 'jpy', #日本円
    )
    redirect_to "/"
  end

  private

  # def set_item
  #   @item = Item.find(params[:id])
  #   @address = Address.find_by(user_id:current_user.id)
  # end

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end
  
  def set_customer # 保管した顧客IDでpayjpから情報取得
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_information # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @card_information = @customer.cards.retrieve(@card.card_id)
  end

  def take_card
    @card = Card.find_by(user_id: current_user.id)
  end
end
