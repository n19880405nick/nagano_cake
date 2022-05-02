class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.total_payment = 0
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order.total_payment += cart_item.subtotal
    end
    @order.total_payment += @order.shipping_cost
    @order.order_status = 0
    @order.save
    @cart_items.each do |cart_item|
      @order_details = @order.order_details.new
      @order_details.item_id = cart_item.item.id
      @order_details.order_id = @order.id
      @order_details.price = cart_item.item.with_tax_price
      @order_details.amount = cart_item.amount
      @order_details.making_status = 0
      @order_details.save
    end
    current_customer.cart_items.destroy_all
    redirect_to thanks_path
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @total = 0
  end
  
  def confirm
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @total = 0
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    @order.save
    @cart_items = current_customer.cart_items.all
    render :confirm
  end
  
  def thanks
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :address, :postal_code, :name, 
                                :select_address, :address_id, :shipping_cost, :total_payment)
  end
end
