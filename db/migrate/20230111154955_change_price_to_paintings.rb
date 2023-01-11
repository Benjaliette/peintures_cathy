class ChangePriceToPaintings < ActiveRecord::Migration[7.0]
  def change
    remove_monetize :paintings, :price, currency: { present: false }
    add_monetize :paintings, :price, amount: { null: true, default: nil }, currency: { null: true, default: nil }
  end
end
