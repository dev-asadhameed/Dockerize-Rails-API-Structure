# frozen_string_literal: true

class ChallengeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_time, :end_time, :published_at, :user_id
end
