# frozen_string_literal: true

module PolicyHandler
  extend ActiveSupport::Concern

  private

  def verified_role(role)
    user.public_send("#{role}?")
  end

  def roles(action)
    "#{self.class}::#{action.upcase}_ROLES".constantize
  end
end
