# frozen_string_literal: true

class SubmissionPolicy < ApplicationPolicy
  CREATE_ROLES = %w[participant].freeze
  INDEX_ROLES = %w[all].freeze
  SHOW_ROLES = %w[all].freeze
  UPDATE_ROLES = %w[participant admin].freeze
  DESTROY_ROLES = %w[participant admin].freeze

  private

  def owner?
    record.submitted_by_id == user.id
  end
end
