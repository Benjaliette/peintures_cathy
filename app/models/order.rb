class Order < ApplicationRecord
  extend FriendlyId
  friendly_id :set_slug, use: :slugged

  # Add monetize gem
  monetize :amount_cents

  # Associations
  belongs_to :user
  belongs_to :painting

  accepts_nested_attributes_for :user, allow_destroy: true

  validates :address, presence: true

  def complete_order(user)
    self.amount = self.painting.price
    self.user = user
    self.state = 'pending'
  end

  def set_stripe_paiement(success_url, cancel_url)
    customer = set_stripe_customer
    product = set_stripe_product(self.painting)
    price = set_stripe_price(product, self.painting)

    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: price.id,
        quantity: 1,
      }],
      customer: customer,
      mode: 'payment',
      success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url
    )
  end

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

  def set_stripe_product(painting)
    Stripe::Product.create(
      name: painting.title,
      images: [painting.photo.url]
    )
  end

  def set_stripe_price(product, painting)
    Stripe::Price.create({
      unit_amount: painting.price_cents,
      currency: 'eur',
      product: product.id
    })
  end

  def set_stripe_customer
    Stripe::Customer.create({
      address: self.user.cut_address_in_parts,
      email: self.user.email,
      name: "#{self.user.first_name} #{self.user.last_name}",
      metadata: { id: self.user.id }
    })
  end
end
