class WelcomesController < ApplicationController
    def index        
        
    end
    
    def create
        user = User.authenticate(params[:user_name], params[:password])
        if user
            usuario = User.find(user.id)
            empleado = Staff.find(usuario.staff_id)

            session[:user_id] = user.id
            session[:empleado_id] = empleado.staff_id
            session[:user_name] = empleado.name
            session[:tipo_usuario] = empleado.type_id
            session[:sucursal_usuario] = empleado.branch_id
            redirect_to bienvenido_path
        else
            flash.now.alert = "Usuario o contraseña invalidos"
            render "index"
        end
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to root_path, :notice => "Logged out!"
    end

    def cerrar_sesion
        reset_session
        redirect_to users_path, :notice => 'Sesión Cerrada'
    end

    def bienvenido
        if session[:user_name].nil?
            redirect_to welcomes_path
        end

        @empleado = Staff.find(session[:empleado_id])
        @datos_puesto = StaffType.find(@empleado.type_id)
        @sucursal = Branch.find(@empleado.branch_id)
    end
end
