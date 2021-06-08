# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/submissions_controller', type: :request do
  path '/api/v1/submissions/{id}' do
    get 'Returns a submissions' do
      tags 'Submissions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      security [Bearer: []]

      response '200', 'Submission found' do
        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/submissions' do
    post 'Creates a submissions' do
      tags 'Submissions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      security [Bearer: []]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          practice_submissions_count: { type: :integer },
          flagged: { type: :boolean },
          status: { type: :string },
          challenge_id: { type: :integer }
        }
      }

      response '201', 'Submission created successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/submissions/{id}' do
    put 'Update a submissions' do
      tags 'Submissions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      security [Bearer: []]
      parameter in: :body, schema: {
        type: :object,
        properties: {
          practice_submissions_count: { type: :integer },
          flagged: { type: :boolean },
          status: { type: :string }
        }
      }

      response '200', 'Submission updated successfully' do
        run_test!
      end
    end
  end
end
