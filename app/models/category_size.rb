class CategorySize < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :item_size, optional: true
end
