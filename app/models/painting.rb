class Painting < ApplicationRecord
  # Money rails determining price
  monetize :price_cents

  # Associations
  has_many :orders, dependent: :destroy

  # Validations
  validates :title, :description, :price, presence: true

  # Active Storage
  has_one_attached :photo
end
