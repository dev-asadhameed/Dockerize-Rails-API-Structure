# frozen_string_literal: true

# Submission Model
class Submission < ApplicationRecord
  has_one :attachment
  belongs_to :challenge
  belongs_to :submitted_by, class_name: 'User'

  # scopes
  scope :for_status, ->(status) { where(status: status) }
  scope :for_flagged, ->(flagged) { where(flagged: flagged) }
  scope :for_challenge, ->(challenge_id) { where(challenge_id: challenge_id) }
  scope :for_practice_submissions_count, ->(count) { where(practice_submissions_count: count) }
end
