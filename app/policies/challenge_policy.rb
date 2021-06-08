# frozen_string_literal: true

class ChallengePolicy < ApplicationPolicy
  CREATE_ROLES = %w[creator].freeze
  INDEX_ROLES = %w[all].freeze
  UPDATE_ROLES = %w[creator admin].freeze
  DESTROY_ROLES = %w[creator admin].freeze

  class Scope < Scope
    include PolicyHandler

    def resolve
      if verified_role(:admin)
        scope.all
      elsif verified_role(:viewer) || verified_role(:participant) || verified_role(:reviewer) ||
            verified_role(:judge)
        scope.where.not(published_at: nil)
      elsif verified_role(:creator)
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end

  def show?
    record.user_id == user.id || record.published_at.present?
  end

  private

  def owner?
    record.user_id == user.id
  end
end
