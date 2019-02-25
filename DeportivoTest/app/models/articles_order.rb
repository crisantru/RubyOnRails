class ArticlesOrder < ActiveRecord::Base
	belongs_to :orders
	belongs_to :articles
    
    validates_presence_of :price, :message => '^El campo precio no debe estar vacío'
    validates_presence_of :total_article, :message => '^Se debe ingresar una cantidad de productos'
    validates_presence_of :orders_id, :message => "^Se debe crear primero una solicitud de compra en el apartado 'compras'"

    validates_inclusion_of :price,
		:within => 1..1.0/0,
		:message => '^El precio debe ser positivo'

	validates_inclusion_of :total_article,
		:within => 1..1.0/0,
		:message => '^Se debe ingresar una cantidad positiva de productos'

	before_validation do
    	self.subtotal = price * total_article
  	end

end
