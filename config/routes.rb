Rails.application.routes.draw do
  root "top#index"

  resources :meals, only: [:create, :index, :update, :destroy] do
    collection do
      patch :update_all
    end
  end
end

