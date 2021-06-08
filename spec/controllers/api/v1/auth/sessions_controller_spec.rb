# frozen_string_literal: true

require 'rails_helper'

describe 'Api V1 Auth SessionsController', type: :request do
  let(:user) { create(:user) }
  let(:authorized_user) { create(:user, confirmed_at: DateTime.now, access_token: SecureRandom.hex) }

  describe '#login' do
    context 'When user is not confirmed and try to login' do
      before do
        login_with_api(user)
      end

      it 'returns unauthorized error' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When user is confirmed and login successfully' do
      before do
        post user_session_path, params: {
          email: authorized_user.email,
          password: authorized_user.password
        }, headers: {
          'X-AUTH-TOKEN' => authorized_user.access_token
        }
      end

      it 'user has access token' do
        expect(JSON.parse(response.body)['user']['access_token']).to be_present
      end

      it 'returns success response' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When user fails to login' do
      let(:params) do
        {
          user: {
            email: user.email,
            password: nil
          }
        }
      end

      it 'returns not found error' do
        post '/login', params: params

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
