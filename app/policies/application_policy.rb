# frozen_string_literal: true

class ApplicationPolicy
  include PolicyHandler

  CREATE_ROLES = [].freeze
  UPDATE_ROLES = [].freeze
  DESTROY_ROLES = [].freeze
  SHOW_ROLES = [].freeze
  INDEX_ROLE = [].freeze

  attr_reader :user, :record

  def initialize(context, record)
    @user = context.user
    @record = record
  end

  %i[index create update destroy show].each do |action|
    define_method("#{action}?") do
      return true if (roles(action) & %w[all]).any?

      return true if (roles(action) & %w[admin] & user.roles.pluck(:name)).any?

      (roles(action) & user.roles.pluck(:name)).any? && owner?
    end
  end

  class Scope
    attr_reader :scope, :user

    def initialize(context, scope)
      @scope = scope
      @user = context.user
    end

    def resolve
      scope.all
    end
  end

  private

  def owner?
    false
  end
end
