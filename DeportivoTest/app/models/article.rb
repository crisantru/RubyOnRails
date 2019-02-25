class Article < ActiveRecord::Base
	has_many :shipments_aricle
	has_many :inventories
	has_many :sales_article
	has_many :aricles_order
 	belongs_to :articles_bill

  	#validates :name, presence: { strict: true } 
  	validates_presence_of :name, :message => '^Ingresar nombre'
  	validates_presence_of :model, :message => '^Se debe especificar un modelo'
  	validates_presence_of :price, :message => '^Se debe ingresar el precio del producto'
  	validates_uniqueness_of :model, :message => '^Ya existe un articulo con ese modelo'

  	validates :name, length: {
  		maximum: 40,
  		too_long: "^El nombre no debe contener más de %{count} caracteres"
  	}

    validates_inclusion_of :price,
		:within => 1..1.0/0,
		:message => '^El precio debe ser positivo' 

	before_validation(on: :create, on: :update) do
		if description.blank?
			self.description = 'sin descripción'
		end
	end
end
