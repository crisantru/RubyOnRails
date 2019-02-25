class AddMatriculaPromedioCarreraFechaEgresoEmpleoLugarEmpleoAreaTrabajoIdiomaToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :matricula, :string
    add_column :users, :promedio, :string
    add_column :users, :carrera, :string
    add_column :users, :fechaEgreso, :string
    add_column :users, :empleo, :string
    add_column :users, :lugarEmpleo, :string
    add_column :users, :areaTrabajo, :string
    add_column :users, :idioma, :string
  end
end
