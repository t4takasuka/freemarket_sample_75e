class ItemsController < ApplicationController
  before_action :set_item, except: %i[index new create]
  before_action :move_to_session, except: %i[index show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "商品を出品しました"
    else
      flash.now[:alert] = "必須項目をすべて入力してください"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: "商品を更新しました"
    else
      flash.now[:alert] = "必須項目をすべて入力してください"
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "商品を削除しました"
    else
      redirect_to root_path, notice: "削除に失敗しました"
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, images_attributes: %i[src _destroy id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_session
    redirect_to new_user_registration_path unless user_signed_in?
  end
end
