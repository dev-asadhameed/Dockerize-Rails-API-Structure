# frozen_string_literal: true

require 'faker'
require 'factory_bot_rails'

module UserHelpers
  def create_user
    FactoryBot.create(:user,
                      user_name: 'random_user1',
                      email: Faker::Internet.unique.email,
                      phone_number: Faker::PhoneNumber.cell_phone,
                      password: 'test12345',
                      password_confirmation: 'test12345')
  end

  def build_user
    FactoryBot.build(:user,
                     user_name: 'random_user2',
                     email: Faker::Internet.unique.email,
                     phone_number: Faker::PhoneNumber.cell_phone,
                     password: 'test12345',
                     password_confirmation: 'test12345')
  end
end
