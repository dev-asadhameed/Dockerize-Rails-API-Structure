# frozen_string_literal: true

# Attachment model
class Attachment < ApplicationRecord
  belongs_to :challenge, optional: true
  belongs_to :submission, optional: true

  # scopes
  scope :for_name, ->(name) { where(name: name) }
  scope :for_submission, ->(submission_id) { where(submission_id: submission_id) }
  scope :for_challenge, ->(challenge_id) { where(challenge_id: challenge_id) }

  def source
    challenge || submission
  end
end
