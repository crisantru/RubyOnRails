class ArticlesBill < ActiveRecord::Base
    has_many :article
    belongs_to :sale
    belongs_to :bill

    validates_presence_of :bills_id, :message => '^Especificar número de factura'
end
