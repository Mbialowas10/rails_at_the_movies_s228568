Rails.application.routes.draw do
  #resources :pages



  root to: "home#index"
  #get 'home/index'
  get 'production_companies/index'
  get 'production_companies/show'
  get 'movies/index'
  get 'movies/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies, only: [:index, :show] do
    #movies/search/(:format)
    collection do
        get "search"
      end
    end


  resources :production_companies, only: [:index, :show]

  resources :pages, except: [:show] # not show route gets generated
  get '/pages/:permalink' => "pages#permalink", as: 'permalink'

  end
