class SalesArticlesController < ApplicationController
  before_action :set_sales_article, only: [:show, :edit, :update, :destroy]

  # GET /sales_articles
  # GET /sales_articles.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @sales_articles = SalesArticle.all
  end

  # GET /sales_articles/1
  # GET /sales_articles/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /sales_articles/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @sales_article = SalesArticle.new
    sql = "SELECT s_a.sale_article_id, s_a.total_article, s_a.subtotal, a.name, a.model, a.size, a.price FROM sales_articles s_a
INNER JOIN articles a ON s_a.article_id=a.article_id WHERE s_a.sales_id=#{session[:id_venta_session]}"
    @ventas = SalesArticle.find_by_sql(sql)
    obtener_articulos
  end

  # GET /sales_articles/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    
    obtener_articulos
  end

  # POST /sales_articles
  # POST /sales_articles.json
  def create
    @sales_article = SalesArticle.new(sales_article_params)

    respond_to do |format|
      if @sales_article.save
        #format.html { redirect_to @sales_article, notice: 'Sales article was successfully created.' }
          format.html { redirect_to new_sales_article_path }
          format.json { render :show, status: :created, location: @sales_article }
      else
        obtener_articulos
        format.html { render :new }
        format.json { render json: @sales_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_articles/1
  # PATCH/PUT /sales_articles/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to sales_articles_path, notice: 'Sin permisos para editar, inicie como administrador o gerente' }
        #format.json { render :show, location: @sales_article }      
      elsif @sales_article.update(sales_article_params)
        format.html { redirect_to @sales_article}
        format.json { render :show, status: :ok, location: @sales_article }
      else
        obtener_articulos
        format.html { render :edit }
        format.json { render json: @sales_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_articles/1
  # DELETE /sales_articles/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to sales_articles_path, notice: 'Sin permisos para eliminar, inicie como administrador o gerente' }
        #format.json { render :show, location: @sales_article }
      else      
        @sales_article.destroy
        format.html { redirect_to new_sales_article_path }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_article
      @sales_article = SalesArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_article_params
      params[:sales_article].permit(:total_article, :subtotal, :sales_id, :article_id)
    end
end
