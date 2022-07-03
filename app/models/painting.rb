class Painting < ApplicationRecord
  # Money rails determining price
  monetize :price_cents

  # Associations
  has_many :orders

  # Validations
  validates :title, :description, presence: true

  # Active Storage
  has_one_attached :photo
end
