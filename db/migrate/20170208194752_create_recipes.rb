class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :instructions
      t.time :prep_time
      t.time :active_time
      t.time :total_time
      t.integer :serving_size
      t.string :serving_size_description

      t.timestamps
    end
  end
end
