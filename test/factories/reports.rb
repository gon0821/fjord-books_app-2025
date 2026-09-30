# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'テスト日報' }
    content { 'テスト日報の内容になります' }
    association :user
  end
end
