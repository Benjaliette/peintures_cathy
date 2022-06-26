class Painting < ApplicationRecord
  # Associations
  belongs_to :order

  # Validations

  # Active Storage
  has_one_attached :photo
end
