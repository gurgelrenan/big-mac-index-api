Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :big_macs, only: [:index] do
        collection do
          get :latest
        end
      end
    end
  end
  
  root 'api/v1/big_macs#index'
end
