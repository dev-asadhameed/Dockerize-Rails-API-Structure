# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < ::Devise::RegistrationsController
        before_action :incomplete_user?

        def create
          build_resource(sign_up_params)

          if resource.save
            create_default_role(resource)
            create_verification_token(resource)

            render json: { message: 'Confirm your email address before continuing.',
                           user: resource }, status: :ok
          else
            render json: { message: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def user
          @user ||= User.find_by(email: params[:email])
        end

        def incomplete_user?
          return unless user && user.user_name.blank?

          user.update_columns(confirmed_at: nil) if user&.confirmed_at? && user.user_name.blank?
          user.resend_confirmation_instructions

          render json: { message: 'Confirm your email address before continuing.',
                         user: resource }, status: :found
        end

        def create_verification_token(resource)
          resource.update_columns(verification_token: SecureRandom.hex) if resource.verification_token.blank?
        end

        def create_default_role(resource)
          resource.roles.create(name: Role::ROLES_TYPES_MAP[:viewer])
        end

        def sign_up_params
          params.permit(:email, :phone_number, :verification_token)
        end
      end
    end
  end
end
