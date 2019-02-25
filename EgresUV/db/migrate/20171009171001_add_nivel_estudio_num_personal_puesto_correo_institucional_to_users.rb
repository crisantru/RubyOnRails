class AddNivelEstudioNumPersonalPuestoCorreoInstitucionalToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :nivelEstudio, :string
    add_column :users, :numPersonal, :integer
    add_column :users, :puesto, :string
    add_column :users, :correoInstitucional, :string
  end
end
