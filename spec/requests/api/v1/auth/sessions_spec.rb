# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/auth/sessions_controller', type: :request do
  path '/login' do
    post 'Returns user' do
      tags 'Sessions'
      produces 'application/json'
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'User successfully logs in' do
        run_test!
      end
    end
  end
end
