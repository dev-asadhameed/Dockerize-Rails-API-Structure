# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :url
      t.references :challenge, null: false, foreign_key: true
      t.references :submission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
