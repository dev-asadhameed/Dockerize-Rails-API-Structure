# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/auth/registrations_controller', type: :request do
  path '/signup' do
    post 'Creates user' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: %w[email]
      }

      response '200', 'Confirm your email address before continuing.' do
        run_test!
      end
    end
  end

  path '/api/v1/users/confirm_account' do
    post 'Confirms user' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          confirmation_token: { type: :string }
        }
      }

      response '200', 'User confirmed successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/users/check_user_name' do
    post 'Checks username availability' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          user_name: { type: :string },
          email: { type: :string },
          verification_token: { type: :string }
        },
        required: %w[user_name email verification_token]
      }

      response '200', 'Returns username availability' do
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    patch 'Sets username and password' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter in: :body, schema: {
        type: :object,
        properties: {
          user_name: { type: :string },
          password: { type: :string },
          verification_token: { type: :string }
        },
        required: %w[user_name password verification_token]
      }

      response '200', 'User updated successfully.' do
        run_test!
      end
    end
  end

  path '/api/v1/users/resend_confirmation_email' do
    post 'Resends confirmation email' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        }
      }

      response '200', 'Confirm your email address before continuing.' do
        run_test!
      end
    end
  end

  path '/api/v1/users/confirmed_user' do
    post 'Returns confirmation status of user' do
      tags 'Registrations'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        }
      }

      response '200', 'Returns user object' do
        run_test!
      end
    end
  end
end
