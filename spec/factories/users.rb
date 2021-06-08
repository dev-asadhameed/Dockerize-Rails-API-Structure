# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    user_name { 'random_user1' }
    email { Faker::Internet.unique.email }
    phone_number { Faker::PhoneNumber.cell_phone }
    password { 'test12345' }
    password_confirmation { 'test12345' }
  end
end
