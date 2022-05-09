class Admin::OrderDetailsController < ApplicationController
	def update
		@order = Order.find(params[:id])
		@detail = OrderDetail.find(params[:order_detail][:id])
		@detail.update(order_detail_params)
		if @detail.making_status == "making"
			@order.update(order_status: "in_the_making")
		end
		details = @order.order_details.all
		prepare = 0
		details.each do |detail|
			if detail.making_status != "making_completed"
				prepare += 1
			end
		end
		if prepare == 0
			@order.update(order_status: "preparing_to_ship")
		end
		redirect_to admin_order_path(@detail.order_id)
	end
	
	private
	def order_detail_params
	   params.require(:order_detail).permit(:making_status, :id) 
	end
end
