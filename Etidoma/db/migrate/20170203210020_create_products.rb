class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :nombre
      t.string :categoria
      t.text :descripcion
      t.text :especificaciones
      t.text :presentacion

      t.timestamps
    end
    add_attachment :products, :image
  end
end
