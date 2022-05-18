Rails.application.routes.draw do
  get '/employees/:id/claim_gift', to: 'employees#claim_gift', as: :claim_gift
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
