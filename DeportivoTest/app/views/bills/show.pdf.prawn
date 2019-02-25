
@encabezado.each do |encabezado|
	pdf.font_size 18
	pdf.text "#{encabezado.Sucursal}", :align => :center
	pdf.text "#{encabezado.address}", :align => :center
	
	pdf.font_size 12
	pdf.draw_text "Cliente: #{encabezado.Cliente}", :at => [0,470]
	pdf.text "Factura ##{encabezado.Factura}", :align => :right
	
	
	pdf.move_down 10
	pdf.draw_text "RFC: #{encabezado.rfc}", :at => [0,450]
	pdf.text "Fecha: #{encabezado.bill_date}", :align => :right

	pdf.move_down 10
	pdf.text "Vendedor: #{encabezado.Vendedor}", :align => :center
	pdf.move_down(50)
end


array = [['Cantidad', 'Producto', 'Modelo', 'Descripción', 'Precio', 'Subtotal']]
i = 1
total = 0

@productos.each do |p|
	array[i] = []
	array[i] << p.Cantidad.to_i
	array[i] << p.Producto
	array[i] << p.model
	array[i] << p.description
	array[i] << number_to_currency(p.price)
	array[i] << number_to_currency(p.subtotal)
	total += p.subtotal
	i += 1
end
array[i] = []
array[i] << ''
array[i] << ''
array[i] << ''
array[i] << ''
array[i] << 'Total'
array[i] << number_to_currency(total)

pdf.table array,
	:position => :center,
	:column_widths => { 4 => 80, 5 => 80},
	:row_colors => ["FFFFFF","DDDDDD"]

