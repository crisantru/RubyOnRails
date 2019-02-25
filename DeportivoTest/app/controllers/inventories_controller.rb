class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]

  # GET /inventories
  # GET /inventories.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_sucursales  
      
     if not session[:inventories_id].nil?
         @inventarios = Inventory.where("inventories_id = ?", session[:inventories_id])
     elsif not session[:branches_id].nil?
         @inventarios = Inventory.where("branch_id = ?", session[:branches_id])
        else
         
         @inventarios = nil
        
        end
      
      
    @inventories = Inventory.all
      
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /inventories/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @inventory = Inventory.new
      obtener_articulos
      obtener_almacenes
  end

  # GET /inventories/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    
    obtener_articulos
    obtener_almacenes
  end
    
    
   def buscar_por_id
       session.delete(:branches_id)
       inventorie = Inventory.where("inventories_id = ?", params[:inventorie_id])
       session[:inventories_id] = params[:inventorie_id]
       
       #Devuelve un json como salida al navegador.
        render :json => inventorie[0]  
    end
    
    def buscar_por_sucursal
        session.delete(:inventories_id)
        sucursal = Inventory.where("branch_id = ?", params[:branch_id])
        session[:branches_id] = params[:branch_id]
        
        #Devuelve un json como salida al navegador.
        render :json => sucursal[0]
        
    end
        
        
    
    
    

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to new_inventory_path, notice: 'Sin permisos para crear, por favor inice sesión como administrador o gerente' }      
      elsif @inventory.save
        format.html { redirect_to @inventory, notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        obtener_articulos
        obtener_almacenes        
        format.html { render :new }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1
  # PATCH/PUT /inventories/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to inventories_path, notice: 'Sin permisos para editar, por favor inice sesión como administrador o gerente' }
        #format.json { render :show, location: @inventory }      
      elsif @inventory.update(inventory_params)
        format.html { redirect_to @inventory, notice: 'Actualizado' }
        format.json { render :show, status: :ok, location: @inventory }
      else
        obtener_articulos
        obtener_almacenes        
        format.html { render :edit }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to inventories_path, notice: 'Sin permisos para eliminar, por favor inice sesión como administrador' }
        #format.json { render :show, location: @inventory }
      else   
        @inventory.destroy   
        format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_params
      params[:inventory].permit(:number_articles, :branch_id, :article_id)
    end
    
end
