# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/challenges_controller', type: :request do
  path '/api/v1/challenges/{id}' do
    get 'Returns a challenges' do
      tags 'Challenges'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      security [Bearer: []]

      response '200', 'Challenge found' do
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/challenges' do
    post 'Creates a challenges' do
      tags 'Challenges'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      security [Bearer: []]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_time: { type: :string },
          end_time: { type: :string },
          published_at: { type: :string }
        }
      }

      response '201', 'Challenge created successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/challenges/{id}' do
    put 'Update a challenges' do
      tags 'Challenges'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :user_id, in: :path, type: :integer
      security [Bearer: []]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          start_time: { type: :string },
          end_time: { type: :string },
          published_at: { type: :string }
        },
      }

      response '200', 'Challenge updated successfully' do
        run_test!
      end
    end
  end
end
