# frozen_string_literal: true

class AttachmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :challenge_id, :submission_id
end
