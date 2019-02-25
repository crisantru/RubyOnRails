class AddDireccionGeneroFechaNacToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :direccion, :string
    add_column :users, :genero, :string
    add_column :users, :fechaNac, :date
  end
end
