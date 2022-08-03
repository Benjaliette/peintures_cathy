require "open-uri"

class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  before_validation :set_profile_picture
  after_validation :geocode, if: :will_save_change_to_address?

  # Associations
  has_many :orders
  has_many :paintings, through: :orders

  has_one_attached :photo

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
