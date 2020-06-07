class UsersController < ApplicationController
  before_action :move_to_index, except: :show

  def show
    @user = User.find(params[:id])
    @items = Item.where(seller_id: @user.id)
    # @items_on_display = Item.where(seller_id: @user.id, trading_status: 0)
    # @sold_items = Item.where(seller_id: @user.id, trading_status: 1)
    # @buyed_items = Item.where(buyer_id: @user.id, trading_status: 1)
  end

  def logout
    @categories = Category.all
  end

  def mypage
    @categories = Category.order(:id)
  end

  private

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end
