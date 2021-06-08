# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < ::Devise::SessionsController
        include ExceptionHandler

        before_action :user_confirmed?, :password_valid?

        def create
          sign_in(resource_name, user) if user.persisted?

          render json: { user: user }
        end

        private

        def user
          @user ||= User.find_by!(email: params[:email])
        end

        def user_confirmed?
          raise UserNotConfirmed unless user.confirmed_at?
        end

        def password_valid?
          raise PasswordNotValid unless user.valid_password?(params[:password])
        end
      end
    end
  end
end
