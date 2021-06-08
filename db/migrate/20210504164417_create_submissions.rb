# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.integer :practice_submissions_count
      t.boolean :flagged
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
