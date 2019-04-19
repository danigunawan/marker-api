Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :markers, only: [:index, :create] do
    collection do
      post 'delete'
    end
  end
end
