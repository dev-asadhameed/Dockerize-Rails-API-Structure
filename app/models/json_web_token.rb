# frozen_string_literal: true

class JsonWebToken
  def self.decode(token)
    token = token.split.second if token.split.second.present?
    JWT.decode(token, Rails.application.credentials.jwt_key[:DEVISE_JWT_SECRET_KEY]).first
  end
end
