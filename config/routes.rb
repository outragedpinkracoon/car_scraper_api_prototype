Rails.application.routes.draw do
  get '/cars/used', to: 'cars#used', defaults: { max: '5' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
