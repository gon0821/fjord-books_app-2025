# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'テスト本' }
    memo { 'テスト初心者向けの内容です' }
    author { '山田 太郎' }
    picture { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/ruby_book.jpg'), 'image/jpeg') }
  end
end
