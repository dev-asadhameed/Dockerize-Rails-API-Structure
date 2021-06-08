# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/users_controller', type: :request do
  path '/api/v1/users/{id}' do
    get 'Returns an users' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      security [Bearer: []]

      response '200', 'User found' do
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    put 'Updates user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      security [Bearer: []]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          phone_number: { type: :string }
        }
      }

      response '200', 'Updated user successfully' do
        run_test!
      end
    end
  end
end
