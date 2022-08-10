class Order < ApplicationRecord
  # Add monetize gem
  monetize :amount_cents

  # Associations
  belongs_to :user
  belongs_to :painting

  accepts_nested_attributes_for :user, allow_destroy: true

  validates :address, presence: true
end
