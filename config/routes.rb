Rails.application.routes.draw do
  get 'admin/index'
  root "user#index"

  post 'user/sign_in', as: 'sign_in'
  get 'certificate/index'
  get 'certificate/show'
  post 'certificate/create_certificate', as: 'create_certificate'
  get 'certificate/download', defaults: { format: :pdf }, as: 'download_certificate'
  get 'admin/download_data', as: "download_data"
  get 'admin/download_report', as: "download_report"
  match "/500", to: "application#internal_server_error", via: :all

end
