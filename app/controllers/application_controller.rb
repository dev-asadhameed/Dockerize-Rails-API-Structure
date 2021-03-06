# frozen_string_literal: true

class ApplicationController < ActionController::Base
  respond_to :json
  skip_before_action :verify_authenticity_token
end
