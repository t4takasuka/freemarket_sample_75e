class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:id)
    @category_parent = Category.all.where(ancestry: nil)
  end

  def show
  end
end
