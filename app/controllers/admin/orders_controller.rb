class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @total = 0
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "payment_confirmation"
			@order.order_details.update_all(making_status: "waiting_for_making")
    end
		redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_params
    params.require(:order).permit(:order_status)    
  end
end
