# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :email
end
