Rails.application.routes.draw do
  devise_for :users
  root to: "domains#search"  

  resources :users
  resources :registrants
  resources :details
  resources :domains

  get 'search/result' => 'domains#result', :as => 'result_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
