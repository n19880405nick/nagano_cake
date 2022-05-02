class Admin::OrderDetailsController < ApplicationController
    def update
        @order = Order.find(params[:id])
        @order.order_details.update(order_detail_params)
        redirect_to admin_order_path(@order.id)
    end
    
    private
    def order_detail_params
       params.require(:order_detail).permit(:making_status) 
    end
end
