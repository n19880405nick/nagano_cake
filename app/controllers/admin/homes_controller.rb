class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @orders = Order.all.page(params[:page]).per(10)
  end
  
  def customer_orders
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.all.page(params[:page]).per(10)
  end
end
