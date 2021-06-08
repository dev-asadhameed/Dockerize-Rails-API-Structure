# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      include ExceptionHandler

      before_action :validate_access_token, :authenticate_user, :verify_user, :pundit_user, only: :update

      actions :show

      def update
        resource.update_columns(verification_token: nil) if resource.verification_token?
        super
      end

      def confirm_account
        if current_resource.confirmed_at.blank?
          current_resource.update_columns(confirmed_at: DateTime.now)

          render json: { message: 'Your account has been confirmed successfully.',
                         user: [id: current_resource.id, verification_token: current_resource.verification_token] }
        elsif current_resource.confirmed_at?
          render json: { message: 'Account already confirmed.', user_id: current_resource.id },
                 status: :unprocessable_entity
        else
          render json: { message: 'Email or token is invalid.' }
        end
      end

      def confirmed_user
        raise UserNotConfirmed unless user.confirmed_at?

        render json: user, status: :ok
      end

      def resend_confirmation_email
        if user.confirmed_at?
          render json: { message: 'User is already confirmed!', user_id: user.id }
        else
          user.resend_confirmation_instructions

          render json: { message: 'Confirm your email address before continuing.' }
        end
      end

      def check_user_name
        user_name = User.where(user_name: params[:user_name]).first

        raise UserNotConfirmed unless user.confirmed_at?

        raise InvalidVerificationToken unless user.verification_token == params[:verification_token]

        if user_name.present?
          render json: { message: 'This username is already taken.' }, status: :unprocessable_entity
        else
          render json: { message: 'Username is available.' }, status: :ok
        end
      end

      private

      def user
        @user ||= User.find_by!(email: params[:email])
      end

      def current_resource
        @current_resource ||= User.find_by!(email: params[:email], confirmation_token: params[:confirmation_token])
      end

      def verify_user
        @current_user ||= User.find_by(id: params[:id], verification_token: params[:verification_token])
        raise NonVerifiedUser if @current_user.verification_token.blank? && @current_user.user_name.blank?
      end

      def pundit_user
        current_user = User.find_by!(id: params[:id])
        raise InvalidVerificationToken unless current_user.verification_token == params[:verification_token]

        UserContext.new(current_user)
      end

      def authenticate_user
        token = request.headers['Authorization']
        auth_user = JsonWebToken.decode(token) if token
        @current_user ||= User.find_by(id: auth_user['sub']) if auth_user && params[:id] == auth_user['sub']

        return unless resource.verification_token.blank? && resource.user_name?

        raise UserNotConfirmed if @current_user && @current_user.confirmed_at.blank?

        raise ActionController::InvalidAuthenticityToken if @current_user.blank?
      end

      def validate_access_token
        raise MissingAccessToken if request.headers['Authorization'].blank? &&
                                    resource.verification_token.blank? && resource.user_name?
      end

      def permitted_params
        params.permit(:user_name, :email, :phone_number, :password, :password_confirmation)
      end
    end
  end
end
