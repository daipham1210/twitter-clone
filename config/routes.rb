Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api', format: 'json' do
    resources :tweets, only: %i[index create] do
      member do
        post :retweet
      end
    end
  end
end
