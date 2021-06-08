# frozen_string_literal: true

require 'rails_helper'

describe 'Api V1 Auth RegistrationsController', type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }

  describe '#signup' do
    context 'When creating a new user' do
      let(:params) do
        {
          user_name: user.user_name,
          email: user.email,
          phone_number: user.phone_number,
          password: user.password,
          password_confirmation: user.password
        }
      end

      it 'should send user confirmation email' do
        post '/signup', params: params

        expect(ActionMailer::Base.deliveries.count).to eq 1
      end

      it 'return confirmation msg before continuing' do
        post '/signup', params: params

        expect(response).to have_http_status(:ok)
      end

      it 'should create user' do
        post '/signup', params: params

        expect(User.count).to eq 1
      end

      context 'When an email already exists' do
        before do
          post '/signup', params: {
            user: {
              email: existing_user.email,
              password: existing_user.password
            }
          }
        end

        it 'returns error on already existed email' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'When an email is not given' do
        before do
          post '/signup', params: {
            user: {
              email: nil,
              password: existing_user.password
            }
          }
        end

        it 'returns error if email is not given' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
