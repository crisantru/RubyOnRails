class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    @sales = Sale.all
    
    session.delete(:id_venta_session)
    obtener_empleados
      
    if not session[:find_sales].nil?
        @ventas = Sale.where("sales_id = ?", session[:find_sales])
    elsif not session[:date_sales].nil?
        @ventas = Sale.where("sales_date = ?", session[:date_sales])
    elsif not session[:client_sales].nil?
        @ventas = Sale.where("client_id = ?", session[:client_sales])
     elsif not session[:type_sales].nil?
        @ventas = Sale.where("sales_type = ?", session[:type_sales])
    elsif not session[:staff_sales].nil?
        @ventas = Sale.where("staff_id = ?", session[:staff_sales])
    else
        @ventas = nil
        
    end
      
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end  

    @ventas = SalesArticle.where("sales_id = ?", params[:id])
  end

  # GET /sales/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @sale = Sale.new
      
    obtener_clientes
    obtener_empleados
  end

  # GET /sales/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_clientes
    obtener_empleados     
  end
    
    
   def buscar_por_id
       session.delete(:date_sales)
       session.delete(:client_sales)
       session.delete(:type_sales)
       sale = Sale.where("sales_id = ?", params[:sale_id])
       session[:find_sales] = params[:sale_id]
       
       #Devuelve un json como salida al navegador.
       render :json => sale[0]   
   
    end
    
    
    def buscar_por_fecha
        session.delete(:find_sales)
        session.delete(:client_sales)
        session.delete(:type_sales)
        date = Sale.where("sales_date = ?", params[:sale_date])
        session[:date_sales] = params[:sale_date]
        
        #Devuelve un json como salida al navegador.
        render :json => date[0]   
   
        
    end
    
    
    def buscar_por_cliente
        session.delete(:date_sales)
        session.delete(:find_sales)
        session.delete(:type_sales)
        session.delete(:staff_sales)
        cliente = Sale.where("client_id = ?", params[:client])
        session[:client_sales] = params[:client]
        
         #Devuelve un json como salida al navegador.
        render :json => cliente[0]  
        
    end
    
    
    def buscar_por_tipo_venta
        session.delete(:date_sales)
        session.delete(:find_sales)
        session.delete(:client_sales)
        session.delete(:staff_sales)
        tipo_venta = Sale.where("sales_type = ?", params[:type])
        session[:type_sales] = params[:type]
        
         #Devuelve un json como salida al navegador.
        render :json => tipo_venta[0]
    
    end
    
      def buscar_por_empleado
        session.delete(:date_sales)
        session.delete(:find_sales)
        session.delete(:client_sales)
        session.delete(:type_sales)
        client_sales = Sale.where("staff_id = ?", params[:empleado])
        session[:staff_sales] = params[:empleado]
        
         #Devuelve un json como salida al navegador.
        render :json => client_sales[0]
    
       end
    
    
    
    
  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        #format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
          
        session[:id_venta_session] = @sale.id
        session[:tipo_venta_session] = @sale.sales_type
        format.html { redirect_to new_sales_article_path }
        format.json { render :show, status: :created, location: @sale }
      else
        obtener_clientes
        obtener_empleados          
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to sales_path, notice: 'Sin permisos para editar, inicie como administrador o gerente' }
        #format.json { render :show, location: @sale }
      elsif @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        obtener_clientes
        obtener_empleados          
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to sales_path, notice: 'Sin permisos para eliminar, inicie como administrador' }
        #format.json { render :show, location: @sale }
      else
        @sale.destroy
        format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params[:sale].permit(:sales_type, :sales_date, :client_id, :staff_id)
    end
end
