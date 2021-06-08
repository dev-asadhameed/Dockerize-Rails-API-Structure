# frozen_string_literal: true

class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :practice_submissions_count, :flagged, :status, :challenge_id, :submitted_by_id
end
