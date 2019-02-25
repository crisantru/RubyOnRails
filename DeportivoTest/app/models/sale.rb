class Sale < ActiveRecord::Base
  has_many :sales_articles
  has_many :articles_bills
    
  validates_presence_of :sales_type, :message => '^Especificar tipo de venta'
    
end
