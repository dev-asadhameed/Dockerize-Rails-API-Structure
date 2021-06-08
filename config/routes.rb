Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  default_url_options host: 'localhost:3000' if Rails.env.test?

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :index, :show, :update] do
        post :check_user_name, on: :collection
        post :confirmed_user, on: :collection
        post :confirm_account, on: :collection
        post :resend_confirmation_email, on: :collection

        resource :challenges, only: :create
        resource :submissions, only: :create
      end

      resources :submissions, only: [:index, :show, :update]
      resources :challenges, only: [:index, :show, :update]
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               registrations: 'api/v1/auth/registrations',
               sessions: 'api/v1/auth/sessions'
             }
end
