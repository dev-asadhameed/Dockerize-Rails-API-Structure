# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :published_at
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
