class CardsController < ApplicationController
  require 'payjp'

  before_action :set_card, only: %i[show destroy]
  before_action :set_api_key

  def new
    @card = Card.where(user_id: current_user.id)
    @categories = Category.order(:id)
  end

  def create
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      user_id = current_user.id
      customer = Payjp::Customer.create(
        card: params['payjp-token']
      )
      @card = Card.new(user_id: user_id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        flash[:notice] = '登録しました'
        redirect_to users_mypage_users_path
      else
        flash[:alert] = '登録できませんでした'
        redirect_to new_card_path
      end
    end
  end

  def show
    @categories = Category.order(:id)
    if @card.blank?
      flash[:alert] = 'クレジットカードを登録してください'
      redirect_to new_card_path
    else
      set_customer
      set_card_information
      @card_brand = @card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "Visa.gif"
      when "MasterCard"
        @card_src = "Mastercard.gif"
      when "SASION"
        @card_src = "Saison.gif"
      when "JCB"
        @card_src = "Saison.gif"
      when "AMERICAN"
        @card_src = "amex.gif"
      when "DinnersClub"
        @card_src = "Diners.gif"
      when "DISCOVER"
        @card_src = "DISCOVER.gif"
      end
    end
  end

  def destroy
    if @card.save
      flash[:alert] = 'クレジットカードを削除しました'
      set_customer
      @customer.delete
      @card.delete
    end
    redirect_to new_card_path
  end

  private

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

  def set_customer # 保管した顧客IDでpayjpから情報取得
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_information # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @card_information = @customer.cards.retrieve(@card.card_id)
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end
end
