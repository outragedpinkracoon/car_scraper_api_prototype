Rails.application.routes.draw do
  get '/cars/by_type', to: 'cars#by_type'
  get '/cars/for_data_processing', to: 'cars#for_data_processing'
end
