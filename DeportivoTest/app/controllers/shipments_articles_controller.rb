class ShipmentsArticlesController < ApplicationController
  before_action :set_shipments_article, only: [:show, :edit, :update, :destroy]

  # GET /shipments_articles
  # GET /shipments_articles.json
  def index
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @shipments_articles = ShipmentsArticle.all
  end

  # GET /shipments_articles/1
  # GET /shipments_articles/1.json
  def show
    if session[:user_name].nil?
      redirect_to welcomes_path
    end
  end

  # GET /shipments_articles/new
  def new
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    @shipments_article = ShipmentsArticle.new
    obtener_articulos
  end

  # GET /shipments_articles/1/edit
  def edit
    if session[:user_name].nil?
      redirect_to welcomes_path
    end

    obtener_articulos
  end

  # POST /shipments_articles
  # POST /shipments_articles.json
  def create
    @shipments_article = ShipmentsArticle.new(shipments_article_params)

    respond_to do |format|
      if @shipments_article.save
        format.html { redirect_to @shipments_article, notice: 'Shipments article was successfully created.' }
        format.json { render :show, status: :created, location: @shipments_article }
      else
        obtener_articulos
        format.html { render :new }
        format.json { render json: @shipments_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments_articles/1
  # PATCH/PUT /shipments_articles/1.json
  def update
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to shipments_articles_path, notice: 'Sin permisos para editar, inicie como administrador o gerente' }
        #format.json { render :show, location: @shipments_article }
      elsif @shipments_article.update(shipments_article_params)
        format.html { redirect_to @shipments_article, notice: 'Shipments article was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipments_article }
      else
        obtener_articulos
        format.html { render :edit }
        format.json { render json: @shipments_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments_articles/1
  # DELETE /shipments_articles/1.json
  def destroy
    
    respond_to do |format|
      if not session[:tipo_usuario] == 1 and not session[:tipo_usuario] == 2
        format.html { redirect_to shipments_articles_path, notice: 'Sin permisos para eliminar, inicie como administrador o gerente' }
        #format.json { render :show, location: @shipments_article }
      else
        @shipments_article.destroy
        format.html { redirect_to shipments_articles_url, notice: 'Shipments article was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipments_article
      @shipments_article = ShipmentsArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipments_article_params
      params[:shipments_article]
    end
end
