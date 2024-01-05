Rails.application.routes.draw do
  root 'landings#index'
  devise_for :users

  resource :landings, only: %i[index] do
    post :send_alert
  end
end
