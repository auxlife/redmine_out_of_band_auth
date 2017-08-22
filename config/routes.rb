Rails.application.routes.draw do
  resources :totp_auths do
    collection do
      get :login
      post :login
    end
  end
end
