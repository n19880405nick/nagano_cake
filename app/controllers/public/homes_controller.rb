class Public::HomesController < ApplicationController
    def top
        @genres = Genre.all
        @item = Item.order( created_at: :desc).limit(4)
    end
    
    def about
    end
    
    def search
        @records = Item.search_for(params[:keyword])
    end
end
