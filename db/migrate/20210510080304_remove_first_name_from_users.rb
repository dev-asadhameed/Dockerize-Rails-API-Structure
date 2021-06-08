# frozen_string_literal: true

class RemoveFirstNameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :first_name
  end
end
