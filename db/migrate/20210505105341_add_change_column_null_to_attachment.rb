# frozen_string_literal: true

class AddChangeColumnNullToAttachment < ActiveRecord::Migration[6.0]
  def change
    change_column_null :attachments, :challenge_id, true
    change_column_null :attachments, :submission_id, true
  end
end
