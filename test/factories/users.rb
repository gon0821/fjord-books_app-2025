# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { 'Password!' }
    password_confirmation { 'Password!' }
  end
end
