class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 

  def obtener_sucursales
    sucursales = Branch.all
    @lista_sucursales = Hash.new
    
    sucursales.each do |sucursal|
        @lista_sucursales[sucursal[:name]] = sucursal[:branch_id]
    end

    # Ordena la hash alfabeticamente
    @lista_sucursales = @lista_sucursales.sort_by {|nombre,id| nombre}    

  end    
    
 
    
  def obtener_articulos
    @articulos = Article.all
    @lista_articulos = Hash.new
    @precio_articulos = Hash.new
        
    @articulos.each do |articulo|
        @lista_articulos[articulo[:name]] = articulo[:article_id]
        @precio_articulos[articulo[:article_id]] = articulo[:price]
    end

    # Ordena la hash alfabeticamente
    @lista_articulos = @lista_articulos.sort_by {|nombre,id| nombre}

  end
    
  def obtener_clientes
    clientes = Client.all
    @lista_clientes = Hash.new
    clientes.each do |cliente|
        @lista_clientes[cliente[:name]] = cliente[:client_id]
    end

    # Ordena la hash alfabeticamente
    @lista_clientes = @lista_clientes.sort_by {|nombre,id| nombre}

  end
    
  def obtener_almacenes
    almacenes = Stock.all
    @lista_almacenes = Hash.new
        
    almacenes.each do |almacen|
        @lista_almacenes[almacen[:address]] = almacen[:stock_id]
    end

    # Ordena la hash alfabeticamente
    @lista_almacenes = @lista_almacenes.sort_by {|nombre,id| nombre}

  end
    
  def obtener_productos
    productos = Article.all
    @lista_productos = Hash.new
    productos.each do |producto|
        @lista_productos[producto[:name]] = producto[:article_id]
    end

    # Ordena la hash alfabeticamente
    @lista_productos = @lista_productos.sort_by {|nombre,id| nombre}

  end    

        
  def obtener_tipos_empleado
    tipo_empleados = StaffType.all
    @lista_tipos = Hash.new
    
    tipo_empleados.each do |tipo|
        @lista_tipos[tipo[:position]] = tipo[:type_id]
    end

  end

  def obtener_empleados
      empleados = Staff.all
      @lista_empleados = Hash.new
      
      empleados.each do |empleado|
          @lista_empleados[empleado[:name] + " " + empleado[:last_name]] = empleado[:staff_id]
      end
      
      # Ordena la hash alfabeticamente
      @lista_empleados = @lista_empleados.sort_by {|nombre,id| nombre}

  end
    
  def obtener_proveedores
      proveedores = Provider.all
      @lista_proveedores = Hash.new
      
      proveedores.each do |proveedor|
          @lista_proveedores[proveedor[:name]] = proveedor[:provider_id]
      end

      # Ordena la hash alfabeticamente
      @lista_proveedores = @lista_proveedores.sort_by {|nombre,id| nombre}

  end
    

  def obtener_ventas
    ventas = Sale.all
    @lista_ventas = Hash.new

    ventas.each do |venta|
      @lista_ventas[venta[:sales_id]] = venta[:sales_id]
    end

    # Ordena la hash
    @lista_ventas = @lista_ventas.sort
  end
end
