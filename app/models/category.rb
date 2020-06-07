class Category < ApplicationRecord
  has_many :category_sizes
  has_many :item_sizes, through: :category_sizes
  has_many :items
  has_ancestry
end
