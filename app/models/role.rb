# frozen_string_literal: true

# Role model
class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  ROLES_TYPES_MAP = {
    admin: 'admin',
    reviewer: 'reviewer',
    participant: 'participant',
    creator: 'creator',
    judge: 'judge',
    viewer: 'viewer'
  }.freeze

  ROLES_TYPES = ROLES_TYPES_MAP.values

  validates :name, inclusion: { in: ROLES_TYPES }
end
