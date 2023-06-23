Rails.application.routes.draw do
  root "user#index"

  post 'user/sign_in', as: 'sign_in'
  get 'certificate/index'
  get 'certificate/show'
  post 'certificate/create_certificate', as: 'create_certificate'
  get 'certificate/download',defaults: { format: :pdf }, as: 'download_certificate'

end
