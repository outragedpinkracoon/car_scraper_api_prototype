Rails.application.routes.draw do
  get '/cars/used/:max', to: 'cars#used'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
