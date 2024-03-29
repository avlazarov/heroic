Heroic::Application.routes.draw do
  resources :player_classes

  resource :account do
    collection do
      get 'logout'
      get 'login'
      post 'process_login'
    end
  end

  resource :player do
    collection do
      get 'use_potion'
      get 'resurrect'
    end
  end

  resource :battle, :controller => :battle do
    collection do
      get 'start'
    end
  end

  resource :inventory do
    resources :items
  end

  root :to => redirect("/account")
end
