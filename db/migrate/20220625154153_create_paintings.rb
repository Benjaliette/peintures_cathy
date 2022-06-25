class CreatePaintings < ActiveRecord::Migration[7.0]
  def change
    create_table :paintings do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
