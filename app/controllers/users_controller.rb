class UsersController < ApplicationController
  before_action :move_to_index, except: :show

  def show
    @categories = Category.order(:id)
    @user = User.find(params[:id])
    # ↓出品商品
    @items = Item.where(seller_id: @user.id).includes([:images])
  end

  def logout
    @categories = Category.order(:id)
  end

  def mypage
    @categories = Category.order(:id)
  end

  def buy
    @categories = Category.order(:id)
    # ↓購入商品
    @items = Item.where(buyer_id: current_user.id)
  end

  private

  def move_to_index
    redirect_to root_path unless user_signed_in?
  end
end
