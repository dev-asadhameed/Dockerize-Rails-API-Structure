# frozen_string_literal: true

# This will take the current user and its signed role.
class UserContext
  attr_reader :user, :current_role

  def initialize(user)
    @user = user
  end
end
