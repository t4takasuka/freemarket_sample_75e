class ItemsController < ApplicationController
  before_action :set_item, except: %i[index new create get_category_children get_category_grandchildren]

  def index
    @items = Item.all
    @categories = Category.order(:id)
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_name]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
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
end
