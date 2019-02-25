class ProductsController < ApplicationController
  #http_basic_authenticate_with name: "ceballosMarin", password: "calderon11",
  #except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new  #varible de instancia que permite
                            #validar mediante el metodo .errors.any? y desplegarlos
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    #render plain: params[:product].inspect   #checar el paso de parametros por url
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product
    else
      render 'new'
    end

  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  private       #clase privada permite la insercion en los campos de la tabla Product
  def product_params
    params.require(:product).permit(:nombre, :categoria, :descripcion, :especificaciones, :presentacion, :image)
  end

end
