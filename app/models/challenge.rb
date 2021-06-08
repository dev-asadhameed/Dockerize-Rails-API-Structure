# frozen_string_literal: true

# Challenge model
class Challenge < ApplicationRecord
  has_many :submissions
  has_one :attachment
  belongs_to :user

  # scopes
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :for_title, ->(title) { where(title: title) }
  scope :for_published_at, ->(published_at) { where(published_at: published_at) }
end
