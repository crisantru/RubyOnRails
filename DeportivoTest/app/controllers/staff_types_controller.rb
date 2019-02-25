class StaffTypesController < ApplicationController
  before_action :set_staff_type, only: [:show, :edit, :update, :destroy]

  # GET /staff_types
  # GET /staff_types.json
  def index
    #if session[:user_name].nil?
      #redirect_to welcomes_path
    #end    
    
    if not session[:tipo_usuario] == 1
      redirect_to articles_path
    end
      
    if not session[:staff_type].nil?
        @tipos = StaffType.where("position = ?", session[:staff_type])
    else
        @tipos = nil
    end

  end

  # GET /staff_types/1
  # GET /staff_types/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

  # GET /staff_types/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
    
    # No permite crear a menos que sea administrador
    if not session[:tipo_usuario] == 1
      redirect_to articles_path
    end

    @staff_type = StaffType.new
  end

  # GET /staff_types/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

    def buscar_por_puesto
        staff_type = StaffType.where("position = ?", params[:type])
        session[:staff_type] = params[:type]
        
        render :json => staff_type[0]
        
    end
    
  # POST /staff_types
  # POST /staff_types.json
  def create
    @staff_type = StaffType.new(staff_type_params)

    respond_to do |format|
      if @staff_type.save
        format.html { redirect_to @staff_type, notice: 'Staff type was successfully created.' }
        format.json { render :show, status: :created, location: @staff_type }
      else
        format.html { render :new }
        format.json { render json: @staff_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staff_types/1
  # PATCH/PUT /staff_types/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to staff_types_path, notice: 'Sin permisos para editar, inicie como administrador' }
        #format.json { render :show, location: @staff_type }
      elsif @staff_type.update(staff_type_params)
        format.html { redirect_to @staff_type, notice: 'Staff type was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff_type }
      else
        format.html { render :edit }
        format.json { render json: @staff_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staff_types/1
  # DELETE /staff_types/1.json
  def destroy
    
    respond_to do |format|
      if true
        format.html { redirect_to staff_types_path, notice: 'Operación solo válida desde el administrador de bases de datos' }
        #format.json { render :show, location: @staff_type }
      else
        @staff_type.destroy
        format.html { redirect_to staff_types_url, notice: 'Staff type was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff_type
      @staff_type = StaffType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_type_params
      params[:staff_type].permit(:position, :pay, :hours)
    end
end
