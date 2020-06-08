class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:id)
    @category_parents = Category.where(ancestry: nil)
    @ladies = Category.find(1)
    @mens = Category.find(138)
    @baby = Category.find(261)
    @interior = Category.find(389)
    @book = Category.find(518)
    @toy = Category.find(577)
    @cosmetic = Category.find(684)
    @appliance = Category.find(781)
    @sports = Category.find(865)
    @handmade = Category.find(974)
    @ticket = Category.find(1025)
    @bike = Category.find(1084)
    @other = Category.find(1154)
  end

  def show
    @category = Category.find(params[:id])
    @items = Item.where(category_id: params[:id])
  end
end
