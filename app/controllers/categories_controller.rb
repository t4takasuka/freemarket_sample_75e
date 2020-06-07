class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:id)
    @category_parent = Category.all.where(ancestry: nil)
    # @ladies = Category.all.where(ancestry: "1")
  end

  def show
    @category = Category.find(params[:id])
  end
end
