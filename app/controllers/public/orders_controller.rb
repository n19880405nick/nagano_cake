class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @select_address = 0
  end
  
  def create

  end

  def index
  end

  def show
  end
  
  def confirm
    @order = Order.new(order_params)
    if @select_address == 0
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name+current_customer.last_name
    elsif @select_address == 1
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    @order.save
    redirect_to confirm_path
  end
  
  def thanks
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :address, :postal_code, :name)
  end
end
