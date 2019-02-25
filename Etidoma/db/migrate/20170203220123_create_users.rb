class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :razonSocial
      t.string :email
      t.string :telefono
      t.text :cotizacion

      t.timestamps
    end
  end
end
