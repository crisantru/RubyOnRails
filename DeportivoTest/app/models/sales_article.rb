class SalesArticle < ActiveRecord::Base
  belongs_to :articles
  belongs_to :sales

  validates_presence_of :total_article 
    
  validates_inclusion_of :total_article,
    :within => 1..1.0/0,
    :message => '^Se debe ingresar una cantidad positiva de productos'
    
  before_validation do
    @seleccionado = Article.find(article_id)
    price = @seleccionado.price
    self.subtotal = total_article * price
  end
end
