Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # route can be updated later.
  resources :users do
    resources :equipments#<----- this is for the lenders/host
  end

  namespace :s do#<----- search
    resources :equipments, only: [:index]#<------ search results
  end

  #this is for searching equipment. The index page will show the cards, and clicking one card will
  # send the user to the /equipments/:equipment_id/show

  resources :equipments, only: [:show]# <----- /equipments/:equipment_id/show ; this shows the details about the equipment
  resources :contracts#<---- contracts should have all CRUD routes. right?
end
