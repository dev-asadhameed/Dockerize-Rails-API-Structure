# frozen_string_literal: true

# user model
class User < ApplicationRecord
  include RoleHandler

  has_many :challenges
  has_many :submissions, dependent: :nullify, foreign_key: 'submitted_by_id', inverse_of: :submitted_by
  has_many :user_roles
  has_many :roles, through: :user_roles, dependent: :destroy

  validates :email, uniqueness: true
  validates :user_name, uniqueness: true, length: { minimum: 10, maximum: 30 },
                        format: { with: /\A\w{10,30}\z/,
                                  message: 'Username must contain no space or special characters' },
                        on: :update
  validates :password, length: { minimum: 8 },
                       format: { with: /\d+/, message: 'Password must contain at least one digit' },
                       if: -> { encrypted_password_changed? }

  validate :valid_email_or_phone_number?

  devise :database_authenticatable, :registerable,
         :confirmable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  def valid_email_or_phone_number?
    return if email? || phone_number?

    errors.add(:base, 'Email or phone number must be present.')
  end
end
