# frozen_string_literal: true

class RemoveAccessTokenFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :access_token
  end
end
