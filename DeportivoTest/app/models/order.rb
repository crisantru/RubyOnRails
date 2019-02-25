class Order < ActiveRecord::Base
	has_many :articles_orders

	#before_validation(on: :create, on: :update) do
		#day = order_date.day
		#month = order_date.month

	# PENDIENTE
		#if month == 2 and day > 28
			#errors.add "fecha", "no valida (#{month} - #{day})"
		#else
			#errors.add "fecha", "no entro al if (#{month} - #{day})"
		#end

	#end
end
