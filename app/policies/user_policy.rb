# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  CREATE_ROLES = %w[all].freeze
  INDEX_ROLES = %w[admin].freeze
  SHOW_ROLES = %w[all].freeze
  UPDATE_ROLES = %w[admin participant creator reviewer judge viewer].freeze
  DESTROY_ROLES = %w[admin].freeze

  private

  def owner?
    record.id == user.id
  end
end
