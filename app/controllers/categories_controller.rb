class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:id)
    # @category_parents = Category.where(ancestry: nil)
    @ladies = Category.find(1)
    @mens = Category.find(115)
    @baby = Category.find(238)
    @interior = Category.find(366)
    @book = Category.find(495)
    @toy = Category.find(554)
    @cosmetic = Category.find(661)
    @appliance = Category.find(758)
    @sports = Category.find(842)
    @handmade = Category.find(951)
    @ticket = Category.find(1002)
    @bike = Category.find(1061)
    @other = Category.find(1131)
  end

  def show
    @categories = Category.order(:id)
    @category = Category.find(params[:id])
    @items = Item.where(category_id: params[:id]).includes([:images])
  end
end
