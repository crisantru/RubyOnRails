class ArticlesBillsController < ApplicationController
  before_action :set_articles_bill, only: [:show, :edit, :update, :destroy]

  # GET /articles_bills
  # GET /articles_bills.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    @articles_bills = ArticlesBill.all
  end

  # GET /articles_bills/1
  # GET /articles_bills/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /articles_bills/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_ventas

    if not session[:id_factura].nil?
      sql = "SELECT articles_bills_id, a_b.bills_id AS numero_factura, a_b.sales_id AS numero_venta, sa.sales_type,
sa.sales_date, c.name AS nombre_cliente, c.rfc, s.name AS vendedor
FROM articles_bills a_b
INNER JOIN sales sa ON a_b.sales_id=sa.sales_id
INNER JOIN clients c ON sa.client_id = c.client_id
INNER JOIN staffs s ON sa.staff_id=s.staff_id WHERE a_b.bills_id=#{session[:id_factura]}"
      @id_venta = session[:id_factura]
      @ventas = ArticlesBill.find_by_sql(sql)
    else
      @id_venta = 1
      @ventas = nil
    end
    
    @articles_bill = ArticlesBill.new
  end

  # GET /articles_bills/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
    obtener_ventas
  end

  # POST /articles_bills
  # POST /articles_bills.json
  def create
    @articles_bill = ArticlesBill.new(articles_bill_params)

    respond_to do |format|
      if session[:id_factura].nil?
        format.html { redirect_to new_articles_bill_path, notice: 'Debe generar una Factura primero' }
      elsif @articles_bill.save
        format.html { redirect_to new_articles_bill_path }
        #format.html { redirect_to @articles_bill, notice: 'Articles bill was successfully created.' }
        #format.json { render :show, status: :created, location: @articles_bill }
      else
        obtener_ventas  
        format.html { render :new }
        format.json { render json: @articles_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles_bills/1
  # PATCH/PUT /articles_bills/1.json
  def update
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 or not session[:tipo_usuario] == 2
        format.html { redirect_to articles_bills_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
        #format.html { redirect_to @articles_bill, notice: 'Sin permisos para editar' }
        #format.json { render :show, location: @articles_bill }
      elsif @articles_bill.update(articles_bill_params)
        format.html { redirect_to @articles_bill, notice: 'Articles bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @articles_bill }
      else
        obtener_ventas  
        format.html { render :edit }
        format.json { render json: @articles_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles_bills/1
  # DELETE /articles_bills/1.json
  def destroy
    
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to articles_bills_path, notice: 'Sin permisos para eliminar, por favor inicie sesión como administrador o gerente' }
        #format.html { redirect_to @articles_bill, notice: 'Sin permisos para eliminar' }
        #format.json { render :show, location: @articles_bill }
      else
        @articles_bill.destroy
        format.html { redirect_to new_articles_bill_path }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articles_bill
      @articles_bill = ArticlesBill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articles_bill_params
      params[:articles_bill].permit(:bills_id, :sales_id)
    end
end
