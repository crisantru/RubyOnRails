class ShipmentsArticle < ActiveRecord::Base
	belongs_to :shipments
	belongs_to :articles
end
