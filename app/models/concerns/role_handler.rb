require 'active_support/concern'

# User roles methods.
module RoleHandler
  extend ActiveSupport::Concern

  def participant?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:participant])
  end

  def admin?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:admin])
  end

  def reviewer?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:reviewer])
  end

  def judge?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:judge])
  end

  def creator?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:creator])
  end

  def viewer?
    roles.pluck(:name).include?(Role::ROLES_TYPES_MAP[:viewer])
  end
end
