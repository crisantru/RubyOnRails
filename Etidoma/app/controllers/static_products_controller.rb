class StaticProductsController < ApplicationController

  def show
    @product = Product.find(params[:id])
  end

  def catalogo
  end

  def ribbons
    @ribbons = Product.all
  end

  def sujetadores
    @sujetadores = Product.all
  end

  def etiquetas
    @etiquetas = Product.all
  end

  def aplicadores_manuales
    @aplicadores = Product.all
  end

  def maquinas_etiquetadoras
    @maquinas = Product.all
  end

  def impresoras_codigo_barras
    @impresoras = Product.all
  end

end
