# frozen_string_literal: true

class AddSubmittedByToSubmissions < ActiveRecord::Migration[6.0]
  def change
    add_reference :submissions, :submitted_by, foreign_key: { to_table: :users }
  end
end
