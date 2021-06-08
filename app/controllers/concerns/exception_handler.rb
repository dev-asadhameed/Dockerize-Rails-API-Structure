# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern
  class UserNotConfirmed < StandardError
  end

  class PasswordNotValid < StandardError
  end

  class MissingAccessToken < StandardError
  end

  class UnconfirmedEmailExist < StandardError
  end

  class NonVerifiedUser < StandardError
  end

  class InvalidVerificationToken < StandardError
  end

  included do
    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { message: 'Record not found.' }, status: :not_found
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      render json: { message: 'Record already exists.' }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |_e|
      render json: { message: 'Unprocessable Entity, missing parameter.' }, status: :unprocessable_entity
    end

    rescue_from ActionController::InvalidAuthenticityToken do |_e|
      render json: { message: 'You are not authorized' }, status: :unauthorized
    end

    rescue_from UserNotConfirmed do |_e|
      render json: { message: 'User is not Confirmed!' }, status: :unprocessable_entity
    end

    rescue_from PasswordNotValid do |_e|
      render json: { message: 'Password is not valid!' }, status: :unprocessable_entity
    end

    rescue_from MissingAccessToken do |_e|
      render json: { message: 'Access Token is missing!' }, status: :unprocessable_entity
    end

    rescue_from UnconfirmedEmailExist do |_e|
      render json: { message: 'Email exist! Please Confirm account!' }, status: :found
    end

    rescue_from Pundit::NotAuthorizedError do |_e|
      render json: { message: 'You are not authorized to perform this action.' }, status: :forbidden
    end

    rescue_from NonVerifiedUser do |_e|
      render json: { message: 'You are not verified user to perform this action.' }, status: :found
    end

    rescue_from InvalidVerificationToken do |_e|
      render json: { message: 'Invalid verification token.' }, status: :found
    end
  end
end
