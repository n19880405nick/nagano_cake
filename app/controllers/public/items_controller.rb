class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items_all = Item.all
    @items = Item.all.order(id: "desc").page(params[:page]).per(8)
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def genre_item
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items_all = @genre.items.all
    @items = @genre.items.all.order(id: "desc").page(params[:page]).per(8)
  end
end
