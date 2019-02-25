class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
    
    obtener_sucursales
      
    if not session[:stock_buscado].nil?
      @stocks_busqueda = Stock.where("stock_id = ?", session[:stock_buscado])
    elsif not session[:stock_buscado_direccion].nil?
      @stocks_busqueda = Stock.where("address LIKE '%#{session[:stock_buscado_direccion]}%'")
    else
      @stocks_busqueda = Stock.where(:branch_id => session[:stock_buscado_sucursal])
    end
    
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

  # GET /stocks/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @stock = Stock.new
      
    obtener_sucursales
  end

  # GET /stocks/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_sucursales
  end

  def buscar_stock_por_id
   session.delete(:stock_buscado_direccion)
   session.delete(:stock_buscado_sucursal)
   stock = Stock.where(:stock_id => params[:stock_id])
  
   #Devuelve un json como salida al navegador.
   session[:stock_buscado] = params[:stock_id]
   render :json => stock[0]
  end

  def buscar_stock_por_direccion
   session.delete(:stock_buscado)
   session.delete(:stock_buscado_sucursal)
   stock = Stock.where("address LIKE '%#{params[:address]}%'")
   
   #Devuelve un json como salida al navegador.
   session[:stock_buscado_direccion] = params[:address]
   render :json => stock[0]
  end

  def buscar_stock_por_sucursal
    session.delete(:stock_buscado)
    session.delete(:stock_buscado_direccion)
    stock = Stock.where(:branch_id => params[:branch])

    session[:stock_buscado_sucursal] = params[:branch]
    render :json => stock[0]
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to stocks_path, notice: 'Sin permisos, solo el administrador puede crear almacenes' }
      elsif @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        obtener_sucursales
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to stocks_path, notice: 'Sin permisos para editar, inicie como administrador' }
        #format.json { render :show, location: @stock }
      elsif @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        obtener_sucursales
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to stocks_path, notice: 'Sin permisos para eliminar, inicie como administrador' }
        #format.json { render :show, location: @stock }
      else      
        @stock.destroy
        format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params[:stock].permit(:stock_type, :address, :phone, :branch_id)
    end
    
end
