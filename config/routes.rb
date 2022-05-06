Rails.application.routes.draw do
  
  # 管理者用コントローラ
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    get '' => 'homes#top', as: 'top'
    get 'customer_orders/:id' => 'homes#customer_orders', as: 'customer_orders'
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
  # 顧客用コントローラ
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    post 'search' => 'homes#search', as: 'search'
    get 'customers/my_page' => 'customers#show', as: 'mypage'
    resource :customers, only: [:edit, :update]
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :addresses, except: [:new, :show]
    resources :items, only: [:index, :show]
    get 'items/genre_item/:id' => 'items#genre_item', as: 'genre_item'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    resources :orders, only: [:new, :create, :index, :show]
  end
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
