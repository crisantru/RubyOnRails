class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_empleados
    @users = User.all
      
      
     if not session[:user_name_id].nil?
         @usuarios = User.where("user_id = ?", session[:user_name_id])
     elsif not session[:user_names].nil?
         @usuarios = User.where("user_name LIKE '%#{session[:user_names]}%'")
     else
         @usuarios = nil
     end
      
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
    
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    if not session[:tipo_usuario] == 1
      redirect_to articles_path
    end

    obtener_empleados
    @user = User.new
   end

      # GET /users/1/edit
   def edit
        if session[:user_name].nil?
          redirect_to welcomes_path
        end
       
       obtener_empleados
       
    end


  def buscar_por_id
      session.delete(:user_names)
      user = User.where("user_id = ?", params[:user])
      session[:user_name_id] = params[:user]
      
      #Devuelve un json como salida al navegador.
      render :json => user[0]   
      
     end
    
  def buscar_por_name
      session.delete(:user_name_id)
      name = User.where("user_name LIKE '%#{params[:name]}%'")
      session[:user_names] = params[:name]
      
      #Devuelve un json como salida al navegador.
      render :json => name[0] 
       
      
   end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        obtener_empleados
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to users_path, notice: 'Sin permisos para editar, inicie como administrador' }
        #format.json { render :show, location: @user }
      elsif @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        obtener_empleados
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to users_path, notice: 'Sin permisos para eliminar, inicie como administrador' }
        #format.json { render :show, location: @user }
      else
        @user.destroy
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:user_name, :password, :password_confirmation, :staff_id)
    end
end
