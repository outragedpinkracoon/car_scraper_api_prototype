Rails.application.routes.draw do
  get '/cars/by_type', to: 'cars#by_type'
end
