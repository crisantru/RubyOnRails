class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  prawnto :prawn => { :top_margin => 50, :page_layout => :landscape }

  # GET /bills
  # GET /bills.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end 
    
    if not session[:bill_date].nil?
      @bills = Bill.where('bill_date = ?', session[:bill_date])
    elsif not session[:bill_client].nil?
      @bills = Bill.where("client_id LIKE '%#{session[:bill_client]}%'")
    else
      @bills = nil
    end

    session.delete(:id_factura)
    
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    session.delete(:id_factura)

    sql = "SELECT a_b.bills_id AS Factura,br.name AS Sucursal, br.address, cl.name AS Cliente, cl.rfc,
bi.bill_date, st.name AS Vendedor
FROM articles_bills a_b
INNER JOIN bills bi ON a_b.bills_id = bi.bills_id
INNER JOIN sales sa ON a_b.sales_id = sa.sales_id
INNER JOIN clients cl ON bi.client_id = cl.client_id
INNER JOIN branches br ON bi.branch_id = br.branch_id
INNER JOIN staffs st ON sa.staff_id = st.staff_id
WHERE a_b.bills_id = #{params[:id]} LIMIT 1"
    @encabezado = ArticlesBill.find_by_sql(sql)

    sql = "SELECT s_a.total_article AS Cantidad, a.name AS Producto, a.model,
a.description, a.price, s_a.subtotal, a_b.bills_id AS Factura
FROM sales_articles s_a
INNER JOIN articles a ON s_a.article_id = a.article_id
INNER JOIN articles_bills a_b ON s_a.sales_id = a_b.sales_id WHERE a_b.bills_id = #{params[:id]}"


    @productos = SalesArticle.find_by_sql(sql)

  end

  # GET /bills/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @bill = Bill.new
    obtener_sucursales
    obtener_clientes
  end

  # GET /bills/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end     
    
    obtener_sucursales
    obtener_clientes
  end

  def buscar_por_fecha
    session.delete(:bill_client)
    bills = Bill.where('bill_date = ?', params[:fecha])
    session[:bill_date] = params[:fecha]

    #Devuelve un json como salida al navegador.
    render :json => bills[0]
  end

  def buscar_por_cliente
    session.delete(:bill_date)
    bill = Bill.where("client_id LIKE '%#{params[:cliente]}%'")
    session[:bill_client] = params[:cliente]

    #Devuelve un json como salida al navegador.
    render :json => bill[0]
  end


  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        session[:id_factura] = @bill.id

        format.html { redirect_to new_articles_bill_path }
        #format.json { render :new, location: @articles_bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to bills_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
        #format.json { render :show, location: @bill }      
      elsif @bill.update(bill_params)
        format.html { redirect_to @bill}
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to bills_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
      else      
        @bill.destroy
        format.html { redirect_to bills_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params[:bill].permit(:bill_date, :branch_id, :client_id)
    end
        
end
