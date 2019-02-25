class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :nombre
      t.string :apodo
      t.float :peso
      t.float :altura
      t.integer :vida

      t.timestamps null: false
    end

      add_attachment :pokemons, :image
  end
end
