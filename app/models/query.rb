class Query
  include ActiveModel::Model

  attr_accessor :name, :email, :body, :photo

  validates :name, :email, :body, :photo, presence: true
end
