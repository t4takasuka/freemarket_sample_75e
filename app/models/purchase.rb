class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :card
end
