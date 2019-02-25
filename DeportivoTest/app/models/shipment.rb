class Shipment < ActiveRecord::Base
	has_many :shipments_articles

	validates_presence_of :sale_id, :message => '^Se debe crear una orden de venta primero'
end
