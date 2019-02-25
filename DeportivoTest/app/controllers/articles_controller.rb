class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
    
    definir_selects

    @articles = Article.all
    if not session[:articulo_buscado_categoria].nil?
      @articles_busqueda = Article.where("category = ? ", session[:articulo_buscado_categoria])
    elsif not session[:articulo_buscado_marca].nil?
      @articles_busqueda = Article.where("patent = ? ", session[:articulo_buscado_marca])
    elsif not session[:articulo_buscado_modelo].nil?
      @articles_busqueda = Article.where("model = ? ", session[:articulo_buscado_modelo])
    else
      @articles_busqueda = nil
    end

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end    
  end

  # GET /articles/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @article = Article.new

    definir_selects
  end

  # GET /articles/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    definir_selects
  end

  def buscar_por_categoria
   session.delete(:articulo_buscado_marca)
   session.delete(:articulo_buscado_modelo)
   articulo = Article.where("category = ? ", params[:categoria])
  
   #Devuelve un json como salida al navegador.
   session[:articulo_buscado_categoria] = params[:categoria]
   render :json => articulo[0]
  end

  def buscar_por_marca
    session.delete(:articulo_buscado_categoria)
    session.delete(:articulo_buscado_modelo)
    articulo = Article.where("patent = ?", params[:marca])

    session[:articulo_buscado_marca] = params[:marca]
    render :json => articulo[0]
  end

  def buscar_por_modelo
    session.delete(:articulo_buscado_marca)
    session.delete(:articulo_buscado_categoria)
    articulo = Article.where("model = ?", params[:modelo])

    session[:articulo_buscado_modelo] = params[:modelo]
    render :json => articulo[0]
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        definir_selects
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 
        format.html { redirect_to articles_path, notice: 'Sin permisos para editar, por favor inicie sesión como administrador' }
        #format.html { redirect_to @article, notice: 'Sin permisos para editar' }
        #format.json { render :show, location: @article }      
      elsif @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        definir_selects
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1
        format.html { redirect_to articles_path, notice: 'Sin permisos para eliminar, por favor inicie sesión como administrador' }
        #format.html { redirect_to @article, notice: 'Sin permisos para eliminar' }
        #format.json { render :show, location: @article }
      else
        @article.destroy   
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params[:article].permit(:name, :patent, :description, :model, :category, :size, :gender ,:price)
    end

    def definir_selects
      @categoria = { 'Ropa Deportiva' => 'Ropa Deportiva',
                    'Calzado' => 'Calzado',
                    'Ejercicio y Fitness' => 'Ejercicio y Fitness',
                    'Equipos' => 'Equipos',
                    'Accesorios' => 'Accesorios' }
        
      @marca = {  'NIKE' => 'NIKE',
                 'Adidas' => 'Adidas',
                 'Puma' => 'Puma',
                 'QuickSilver' => 'QuickSilver' }

      @genero = { 'Masculino' => 'M', 'Femenino' => 'F' }

      @talla = { 'Extra Grande' => 'EG', 'Grande' => 'G',
                'Mediana' => 'M', 'Chica' => 'C', 'Infantil' => 'I', 'No Aplica' => 'NA'}
    end
end
