# frozen_string_literal: true

require 'rails_helper'

describe 'Api V1 UsersController', type: :request do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  let(:authorized_user) { create(:user, confirmed_at: DateTime.now, access_token: SecureRandom.hex) }

  describe '#show' do
    context 'When fetching a user' do
      it 'returns success response' do
        get api_v1_user_path(authorized_user.id), headers: {
          'X-AUTH-TOKEN' => authorized_user.access_token
        }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'When a user is missing' do
      before do
        get '/api/v1/users/blank'
      end

      it 'returns not found' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When access token is missing' do
      before do
        get api_v1_user_path(user.id)
      end

      it 'returns unauthorized error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
