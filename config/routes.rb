Rails.application.routes.draw do
  devise_for :users
  root to: "domains#search"  

  resources :users
  resources :registrants
  resources :details
  resources :domains

  get 'search/result' => 'domains#result', :as => 'result_page'
  
  get '/payment/paypal', to: 'payments#paypal'
  post '/payment/create', to: 'payments#create'
  post '/payment/execute', to: 'payments#execute'

  #post '/payment/create' => 'payments#paypal', :as => 'payment_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
