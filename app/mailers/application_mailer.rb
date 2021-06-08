# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.gmail_credentials[:EMAIL]
  layout 'mailer'
end
