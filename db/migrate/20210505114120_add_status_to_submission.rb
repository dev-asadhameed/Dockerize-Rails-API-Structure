# frozen_string_literal: true

class AddStatusToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :submissions, :status, :integer, null: false, default: 0
  end
end
