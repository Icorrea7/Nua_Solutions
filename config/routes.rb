Rails.application.routes.draw do

  root :to => 'messages#index'

  resources :messages do
    resources :inboxes, only: [:update]
  end

end
