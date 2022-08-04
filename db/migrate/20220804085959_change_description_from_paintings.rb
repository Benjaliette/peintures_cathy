class ChangeDescriptionFromPaintings < ActiveRecord::Migration[7.0]
  def change
    change_column :paintings, :description, :text
  end
end
