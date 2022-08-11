class Order < ApplicationRecord
  extend FriendlyId
  friendly_id :painting, use: :slugged

  # Add monetize gem
  monetize :amount_cents

  # Associations
  belongs_to :user
  belongs_to :painting

  accepts_nested_attributes_for :user, allow_destroy: true

  validates :address, presence: true


  private

  def get_random_number
    rand_number = (0...1000).to_a.sample
    case rand_number.to_s.size
    when 1 then return "000#{rand_number}"
    when 2 then return "00#{rand_number}"
    when 3 then return "0#{rand_number}"
    else
      return rand_number
    end
  end

  def set_slug
    "#{Date.today.strftime('%y%m%d%H%M')}-#{('A'...'Z').to_a.sample}#{get_random_number}"
  end
end
