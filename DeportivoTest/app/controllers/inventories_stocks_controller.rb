class InventoriesStocksController < ApplicationController
  before_action :set_inventories_stock, only: [:show, :edit, :update, :destroy]

  # GET /inventories_stocks
  # GET /inventories_stocks.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end 

    @inventories_stocks = InventoriesStock.all
  end

  # GET /inventories_stocks/1
  # GET /inventories_stocks/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end     
  end

  # GET /inventories_stocks/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end     
    @inventories_stock = InventoriesStock.new
  end

  # GET /inventories_stocks/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end     
  end

  # POST /inventories_stocks
  # POST /inventories_stocks.json
  def create
    @inventories_stock = InventoriesStock.new(inventories_stock_params)

    respond_to do |format|
      if @inventories_stock.save
        format.html { redirect_to @inventories_stock, notice: 'Inventories stock was successfully created.' }
        format.json { render :show, status: :created, location: @inventories_stock }
      else
        format.html { render :new }
        format.json { render json: @inventories_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories_stocks/1
  # PATCH/PUT /inventories_stocks/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to inventories_stock_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
        #format.json { render :show, location: @inventories_stock }      
      elsif @inventories_stock.update(inventories_stock_params)
        format.html { redirect_to @inventories_stock }
        format.json { render :show, status: :ok, location: @inventories_stock }
      else
        format.html { render :edit }
        format.json { render json: @inventories_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories_stocks/1
  # DELETE /inventories_stocks/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to inventories_stock_path, notice: 'Sin permisos para eliminar, por favor inicie sesión como administrador' }
        #format.json { render :show, location: @inventories_stock }
      else      
        @inventories_stock.destroy
        format.html { redirect_to inventories_stocks_url, notice: 'Inventories stock was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventories_stock
      @inventories_stock = InventoriesStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventories_stock_params
      params[:inventories_stock].permit(:number_articles, :stock_id, :article_id)
    end
end
