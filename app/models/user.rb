class User < ApplicationRecord
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Associations
  has_many :orders
  has_many :paintings, through: :orders

  has_one_attached :photo

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
