Rails.application.routes.draw do
	root to: "products#index"
  	devise_for :users


	resources :users
	resources :products do
		get 'my_products', on: :new
		resources :images, only: [:create, :destroy]
		get 'new/photos', to: 'images#new'
	end
end
