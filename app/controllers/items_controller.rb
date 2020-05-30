class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.itemimgs.new
  end

  def create
    Item.create(items_params)
    redirect_to root_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def items_params
    params.require(:item).permit(:name, :price, itemimgs_attributes: [:image])
  end
end
