class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  # GET /providers
  # GET /providers.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @providers = Provider.all
      
      
    if not session[:provider_name].nil?
        @proveedores = Provider.where("name LIKE '%#{session[:provider_name]}%'")
    elsif not session[:provider_state].nil?
        @proveedores = Provider.where("state LIKE '%#{session[:provider_state]}%'")
      else
        @proveedores = nil
        
    end
      
      
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /providers/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end
    
    
    def buscar_por_nombre
        session.delete(:provider_state)
       
        name = Provider.where("name LIKE '%#{params[:name]}%'")
        session[:provider_name] = params[:name]
        #Devuelve un json como salida al navegador.
        render :json => name[0]
        
    end
    
    def buscar_por_state
        session.delete(:provider_name)
        

        state = Provider.where("state LIKE '%#{params[:state]}%'")
        session[:provider_state] = params[:state]
        
        #Devuelve un json como salida al navegador.
       render :json => state[0]
        
    end    
        
    
  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to providers_path, notice: 'Sin permisos para editar, inice como administrador' }
        #format.json { render :show, location: @provider }      
      elsif @provider.update(provider_params)
        format.html { redirect_to @provider, notice: 'Actualizado' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to providers_path, notice: 'Sin permisos para eliminar, inice como administrador' }
        #format.json { render :show, location: @provider }
      else      
        @provider.destroy
        format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params[:provider].permit(:name, :city, :state, :address, :phone, :mail)
    end
end
