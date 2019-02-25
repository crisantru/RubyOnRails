class Inventory < ActiveRecord::Base
  belongs_to :articles
  belongs_to :branches
    #belongs_to :

  validates_presence_of :number_articles, :message => '^Ingresar número de artículos'

  validates_inclusion_of :number_articles,
	:within => 1..1.0/0,
	:message => '^El precio debe ser positivo'
end
