class ArticlesOrdersController < ApplicationController
  before_action :set_articles_order, only: [:show, :edit, :update, :destroy]

    respond_to :html, :json
  # GET /articles_orders
  # GET /articles_orders.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @articles_orders = ArticlesOrder.all
  end

  # GET /articles_orders/1
  # GET /articles_orders/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /articles_orders/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @articles_orders = ArticlesOrder.where("orders_id = ?", session[:id_compra_session])
    @articles_order = ArticlesOrder.new
    obtener_articulos
  end

  # GET /articles_orders/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_articulos
  end

  # POST /articles_orders
  # POST /articles_orders.json
  def create
    @articles_order = ArticlesOrder.new(articles_order_params)

    respond_to do |format|
      if @articles_order.save
        #format.html { redirect_to @articles_order, notice: 'Articles order was successfully created.' }
        format.html { redirect_to new_articles_order_path }
        #format.json { render :show, status: :created, location: @articles_order }
      else
        #flash.now[:alert] = @articles_order.errors.full_messages.join("<br>").html_safe
        #render action: "new"
        obtener_articulos
        @articles_orders = ArticlesOrder.where("orders_id = ?", session[:id_compra_session])
        format.html { render :new }
        format.json { render json: @articles_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles_orders/1
  # PATCH/PUT /articles_orders/1.json
  def update
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to new_articles_order_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador o gerente' }
        #format.html { redirect_to @articles_order, notice: 'Sin permisos para editar' }
        #format.json { render :show, location: @articles_order }      
      elsif @articles_order.update(articles_order_params)
        format.html { redirect_to new_articles_order_path }
        #format.html { redirect_to @articles_order, notice: 'Articles order was successfully updated.' }
        #format.json { render :show, status: :ok, location: @articles_order }
      else
        obtener_articulos
        @articles_orders = ArticlesOrder.where("orders_id = ?", session[:id_compra_session])
        format.html { render :edit }
        format.json { render json: @articles_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles_orders/1
  # DELETE /articles_orders/1.json
  def destroy
    
    respond_to do |format|
      # Si el usuario no es administrador o gerente no permite editar
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to new_articles_order_path, notice: 'Sin permisos para eliminar, por favor inicie sesión como administrador o gerente' }
        #format.html { redirect_to @articles_order, notice: 'Sin permisos para eliminar' }
        #format.json { render :show, location: @articles_order }
      else
        @articles_order.destroy
        format.html { redirect_to new_articles_order_path }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articles_order
      @articles_order = ArticlesOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articles_order_params
      params[:articles_order].permit(:total_article, :subtotal, :price, :article_id, :orders_id)
    end
    
    def seleccionado
        articulo = Article.find(params[:article_id])
        @price = articulo.price
        respond_with(@price)
    end
end
