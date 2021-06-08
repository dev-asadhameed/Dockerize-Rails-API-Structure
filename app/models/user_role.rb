# frozen_string_literal: true

# UserRole model which is bridge for user and role
class UserRole < ApplicationRecord
  # Using has many through association because we are expecting more columns in future
  belongs_to :user
  belongs_to :role
end
