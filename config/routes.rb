Rails.application.routes.draw do
  root "user#index"

  post 'user/sign_in', as: 'sign_in'
  get 'certificate/index'
  post 'certificate/create_certificate', as: 'create_certificate'
  get 'certificate/download', as: 'download_certificate'
end
