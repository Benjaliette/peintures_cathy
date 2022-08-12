require "open-uri"

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :complete_name, use: :slugged

  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_create :set_profile_picture
  after_validation :geocode, if: :will_save_change_to_address?

  # Associations
  has_many :orders
  has_many :paintings, through: :orders

  has_one_attached :photo

  def cut_address_in_parts
    address = self.address.split(', ')
    {
      line1: address[0],
      postal_code: address[1].split(' ')[0].to_i,
      city: address[1].split(' ')[1],
      country: address[2] == "France" ? 'FR' : ''
    }
  end

  def complete_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def set_profile_picture
    unless self.photo.attached?
      file = URI.open('https://res.cloudinary.com/dxcrr7aon/image/upload/v1659517750/kmciusgydovfekdvnhxm.png')
      self.photo.attach(io: file, filename: 'default_user.png', content_type: 'image/png')
    end
  end
end
