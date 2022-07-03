class AddAmountToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :checkout_session_id, :string
    add_column :orders, :state, :string
    add_monetize :orders, :amount, currency: { present: false }
  end
end
