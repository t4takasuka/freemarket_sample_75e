class CreditCardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def new
    credit_card = Credit_card.where(user_id: current_user.id).first
    redirect_to action: "index" if credit_card.present?
  end

  def create
    Payjp.api_key = '秘密キー'

    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: "test",
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @credit_card = Credit_card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit_card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  private

  def set_card
    @credit_card = Credit_card.where(user_id: current_user.id).first if Credit_card.where(user_id: current_user.id).present?
  end
end
