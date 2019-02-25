class StaticPagesController < ApplicationController
  def home
  	
  end

  def help
  end

  def about
  end

  def contact
  end

  def perfil
  end

  private       #clase privada permite la insercion en los campos de la tabla Product
	def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation, :telefono, :direccion, :genero,
	   :fechaNac, :matricula, :promedio, :carrera, :fechaEgreso, :empleo, :lugarEmpleo, :areaTrabajo, :idioma, :nivelEstudio,
	   :numPersonal, :puesto, :correoInstitucional, :rol)
	end
end
