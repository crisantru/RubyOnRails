class UsersController < ApplicationController

	def index
    @users = User.all
  	end

	def new
		@user = User.new

	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		
    	@user = User.find(params[:id])
  	end

	def create
		@user = User.new(user_params)
	    if @user.save
		      log_in @user
		      flash[:success] = "Welcome to the Sample App!"
		      redirect_to root_path
		    else
		      render 'new'
	    end
	end

	def update
	    @user = User.find(params[:id])

	    if @user.update(user_params)
	      redirect_to @user
	    else
	      render 'edit'
	    end
  	end

	def destroy
	    @user = User.find(params[:id])
	    @user.destroy

	    redirect_to users_path
  	end

	private       #clase privada permite la insercion en los campos de la tabla Product
	def user_params
	  params.require(:user).permit(:name, :email, :password, :password_confirmation, :telefono, :direccion, :genero,
	   :fechaNac, :matricula, :promedio, :carrera, :fechaEgreso, :empleo, :lugarEmpleo, :areaTrabajo, :idioma, :nivelEstudio,
	   :numPersonal, :puesto, :correoInstitucional, :rol)
	end
end
