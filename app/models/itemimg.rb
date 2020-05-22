class Itemimg < ApplicationRecord
  belongs_to :item
  
  mount_uploader :image, ImageUploader
end
