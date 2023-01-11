class Painting < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Money rails determining price
  monetize :price_cents, allow_nil: true

  # Associations
  has_many :orders, dependent: :destroy

  # Active Storage
  has_one_attached :photo

  # Validations
  validates :title, :description, :photo, presence: true
  validates :price, presence: true, if: :in_sell?

  private

  def in_sell?
    self.sell
  end
end
