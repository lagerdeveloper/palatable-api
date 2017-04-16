class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :title
      t.string :amount

      t.timestamps
    end
  end
end
