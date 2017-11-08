Rails.application.routes.draw do
  get '/cars/used', to: 'cars#used'
end
