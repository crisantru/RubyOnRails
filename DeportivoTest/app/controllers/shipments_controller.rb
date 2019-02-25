class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /shipments
  # GET /shipments.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_clientes
    
    
    
      
    @shipments = Shipment.all
    
    # Destruye sesion venta generada 
    session.delete(:id_venta_session)
      
    if not session[:envio_id].nil?
      @envios = Shipment.where("shipments_id = ?", session[:envio_id])
    elsif not session[:cliente_id].nil?
      @envios = Shipment.where("client_id = ?", session[:cliente_id])
    elsif not session[:envio_status].nil?
      @envios = Shipment.where("status = ?", session[:envio_status])
     else
   
      @envios = nil
    end
  end

  # GET /shipments/1
  # GET /shipments/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

  # GET /shipments/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @shipment = Shipment.new
      
    # Llama a las funciones para crear las listas desplegables
    obtener_clientes
    obtener_sucursales
  end

  # GET /shipments/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    # Llama a las funciones para crear las listas desplegables
    obtener_clientes
    obtener_sucursales      
  end
    
  def buscar_por_id
    session.delete(:cliente_id)
    session.delete(:envio_status)
    shipment = Shipment.where("shipments_id = ?", params[:shipment_id])
    session[:envio_id] = params[:shipment_id]
      
   #Devuelve un json como salida al navegador.
   render :json => shipment[0]   
   
  end


   def buscar_por_cliente
       session.delete(:envio_id)
       session.delete(:envio_status)
       client = Shipment.where("client_id = ?", params[:client_id])
       session[:cliente_id] = params[:client_id]
       
       #Devuelve un json como salida al navegador.
       render :json => client[0]
       
    end
    
     def buscar_por_status
       session.delete(:envio_id)
       session.delete(:cliente_id)
       status = Shipment.where("status = ?", params[:status])
       session[:envio_status] = params[:status]
         
       #Devuelve un json como salida al navegador.
       render :json => status[0]
       
       
       
    end
    
    

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    respond_to do |format|
      if @shipment.save
        #format.html { redirect_to @shipment, notice: 'Shipment was successfully created.' }
        format.html {redirect_to sales_path }
        format.json { render :show, status: :created, location: @shipment }
      else
        obtener_clientes
        obtener_sucursales
        format.html { render :new }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1
  # PATCH/PUT /shipments/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to shipments_path, notice: 'Sin permisos para editar, inicie como administrador o gerente' }
        #format.json { render :show, location: @shipment }
      elsif @shipment.update(shipment_params)
        format.html { redirect_to @shipment, notice: 'Shipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipment }
      else
        obtener_clientes
        obtener_sucursales
        format.html { render :edit }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to shipments, notice: 'Sin permisos para eliminar, inicie como administrador' }
        #format.json { render :show, location: @shipment }
      else
        @shipment.destroy
        format.html { redirect_to shipments_url, notice: 'Shipment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params[:shipment].permit(:status, :client_id, :sale_id)
    end
        
end
