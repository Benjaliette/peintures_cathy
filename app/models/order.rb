class Order < ApplicationRecord
  # Add monetize gem
  monetize :amount_cents

  # Associations
  belongs_to :user
  belongs_to :painting
end
