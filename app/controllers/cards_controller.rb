class CardsController < ApplicationController
  require 'payjp'

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

  private

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end
end
