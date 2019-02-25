class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @clients = Client.all

    if not session[:cliente_buscado_nombre].nil?
      @clientes_buscados = Client.where("name LIKE '%#{session[:cliente_buscado_nombre]}%'")
    elsif not session[:cliente_buscado_rfc].nil?
      @clientes_buscados = Client.where("rfc = ?", session[:cliente_buscado_rfc])
    elsif not session[:cliente_buscado_telefono].nil?
      @clientes_buscados = Client.where("phone = ?", session[:cliente_buscado_telefono])
    else
      @clientes_buscados = nil
    end
        
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /clients/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

  def buscar_por_nombre
    session.delete(:cliente_buscado_rfc)
    session.delete(:cliente_buscado_telefono)
    
    cliente = Client.where("name LIKE '%#{params[:nombre]}%'")
    session[:cliente_buscado_nombre] = params[:nombre]

    #Devuelve un json como salida al navegador.
    render :json => cliente[0]

  end

  def buscar_por_rfc
    session.delete(:cliente_buscado_nombre)
    session.delete(:cliente_buscado_telefono)  

    cliente = Client.where("rfc = ?", params[:rfc])
    session[:cliente_buscado_rfc] = params[:rfc]

    #Devuelve un json como salida al navegador.
    render :json => cliente[0]
  end

  def buscar_por_telefono
    session.delete(:cliente_buscado_nombre)
    session.delete(:cliente_buscado_rfc)    

    cliente = Client.where("phone = ?", params[:telefono])
    session[:cliente_buscado_telefono] = params[:telefono]

    #Devuelve un json como salida al navegador.
    render :json => cliente[0]
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      # Solo administrador y gerente pueden editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to clients_path, notice: 'Sin permisos para editar, por favor inice sesión como administrador o gerente' }
        #format.json { render :show, location: @client }      
      elsif @client.update(client_params)
        format.html { redirect_to @client, notice: 'Actualizado' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to clients_path, notice: 'Sin permisos para eliminar, por favor inice sesión como administrador' }
        #format.json { render :show, location: @client }
      else      
        @client.destroy
        format.html { redirect_to clients_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params[:client].permit(:name, :rfc, :address, :phone, :email, :client_type)
    end
end
