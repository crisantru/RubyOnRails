class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @orders = Order.all
    obtener_almacenes
    session.delete(:id_compra_session)

    if not session[:compra_buscado_fecha].nil?
      @compras_buscadas = Order.where("order_date = ?", session[:compra_buscado_fecha])
    elsif not session[:compra_buscado_almacen].nil?
      @compras_buscadas = Order.where("stock_id = ?", session[:compra_buscado_almacen])
    else
      @compras_buscadas = nil
      
      
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /orders/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @order = Order.new
    
    obtener_proveedores
    obtener_almacenes    
  end

  # GET /orders/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    
    obtener_proveedores
    obtener_almacenes      
  end

  def buscar_por_fecha
    session.delete(:compra_buscado_almacen)
    
    compra = Order.where("order_date = ?", params[:fecha])
    session[:compra_buscado_fecha] = params[:fecha]

    #Devuelve un json como salida al navegador.
    render :json => compra[0]
  end

  def buscar_por_almacen
    session.delete(:compra_buscado_fecha)
    
    compra = Order.where("stock_id = ?", params[:almacen])
    session[:compra_buscado_almacen] = params[:almacen]

    #Devuelve un json como salida al navegador.
    render :json => compra[0]
  end


  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        #format.html { redirect_to @order, notice: 'Order was successfully created.' }
        #format.json { render :show, status: :created, location: @order }
        #format.html { redirect_to edit_user_path(@order) }
    
        session[:id_compra_session] = @order.id
        # Si agrega exitosamente redirecciona a compras_articulos para agregar articulos a la compra recien generada
        format.html { redirect_to new_articles_order_path }
        #format.html { redirect_to new_order_path }
        format.json { render :new, location: @articles_order }
      else
        
        obtener_proveedores
        obtener_almacenes
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to orders_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
        #format.json { render :show, location: @order }      
      elsif @order.update(order_params)
        format.html { redirect_to @order, notice: 'Actializado'}
        format.json { render :show, status: :ok, location: @order }
      else
        
        obtener_proveedores
        obtener_almacenes        
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to orders_path, notice: 'Sin permisos para eliminar, inice sesión como administrador' }
        #format.json { render :show, location: @order }
      else      
        @order.destroy
        format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order].permit(:order_date, :stock_id, :staff_id, :provider_id)
    end
  
  def destroy_order
    session.delete(:id_compra_session)
  end
end
