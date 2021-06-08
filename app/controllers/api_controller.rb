# frozen_string_literal: true

class ApiController < ActionController::API
  include ExceptionHandler
  include Pundit

  respond_to :json
  before_action :validate_access_token, :authenticate_user

  private

  def authenticate_user
    token = request.headers['Authorization']
    auth_user = JsonWebToken.decode(token)
    @current_user ||= User.find_by(id: auth_user['sub'])

    raise UserNotConfirmed if @current_user && @current_user.confirmed_at.blank?

    raise ActionController::InvalidAuthenticityToken if @current_user.blank?
  end

  def validate_access_token
    raise MissingAccessToken if request.headers['Authorization'].blank?
  end

  def pundit_user
    UserContext.new(@current_user)
  end
end
