class AddPriceToPaintings < ActiveRecord::Migration[7.0]
  def change
    add_monetize :paintings, :price, currency: { present: false }
  end
end
