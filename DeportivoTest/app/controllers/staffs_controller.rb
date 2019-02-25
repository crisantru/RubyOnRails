class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    if session[:tipo_usuario] == 3
      redirect_to articles_path
    end

    obtener_sucursales

    if not session[:empleado_por_nombre].nil?
      @empleados = Staff.where("name LIKE '%#{session[:empleado_por_nombre]}%'")
    elsif not session[:empleado_por_apellido].nil?
      @empleados = Staff.where("last_name LIKE '%#{session[:empleado_por_apellido]}%'")
    elsif not session[:empleado_por_telefono].nil?
      @empleados = Staff.where("phone = ?", session[:empleado_por_telefono])
    elsif not session[:empleado_por_sucursal].nil?
      @empleados = Staff.where("branch_id = ?", session[:empleado_por_sucursal])
    else
      @empleados = nil
    end
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
      @staff = Staff.find(params[:id])
  end

  # GET /staffs/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end      
    @staff = Staff.new
      
    obtener_sucursales
    obtener_tipos_empleado
  end

  # GET /staffs/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_sucursales
    obtener_tipos_empleado
  end

  def buscar_por_nombre
    session.delete(:empleado_por_apellido)
    session.delete(:empleado_por_telefono)
    session.delete(:empleado_por_sucursal)
    staff = Staff.where("name LIKE '%#{params[:nombre]}%'")
    session[:empleado_por_nombre] = params[:nombre]

   #Devuelve un json como salida al navegador.
   render :json => staff[0]
  end

  def buscar_por_apellido
    session.delete(:empleado_por_nombre)
    session.delete(:empleado_por_telefono)
    session.delete(:empleado_por_sucursal)
    staff = Staff.where("last_name LIKE '%#{params[:apellido]}%'")
    session[:empleado_por_apellido] = params[:apellido]

   #Devuelve un json como salida al navegador.
   render :json => staff[0]
  end

  def buscar_por_telefono
    session.delete(:empleado_por_nombre)
    session.delete(:empleado_por_apellido)
    session.delete(:empleado_por_sucursal)
    staff = Staff.where("phone = ?", params[:telefono])
    session[:empleado_por_telefono] = params[:telefono]

   #Devuelve un json como salida al navegador.
   render :json => staff[0]
  end

  def buscar_por_sucursal
    session.delete(:empleado_por_nombre)
    session.delete(:empleado_por_apellido)
    session.delete(:empleado_por_telefono)
    staff = Staff.where("branch_id = ?", params[:sucursal])
    session[:empleado_por_sucursal] = params[:sucursal]

   #Devuelve un json como salida al navegador.
   render :json => staff[0]
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      # Los vendedores no pueden crear un empleado
      if session[:tipo_usuario] == 3
        format.html { redirect_to new_staff_path, notice: 'Sin permisos para crear' }
      elsif @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        obtener_sucursales
        obtener_tipos_empleado
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update

    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to staffs_path, notice: 'Sin permisos para editar, inicie como administrador' }
        #format.json { render :show, location: @staff }
      elsif @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        obtener_sucursales
        obtener_tipos_empleado        
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to staffs_path, notice: 'Sin permisos para eliminar, inicie como administrador' }
        #format.json { render :show, location: @staff }
      else
        @staff.destroy
        format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params[:staff].permit(:name, :last_name, :address, :phone, :email, :type_id, :branch_id);
    end

end
