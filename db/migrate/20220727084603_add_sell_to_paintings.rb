class AddSellToPaintings < ActiveRecord::Migration[7.0]
  def change
    add_column :paintings, :sell, :boolean, default: false
  end
end
