# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user1 = build(:user)
    user2 = build(:user, name: nil, email: 'user_2@example.com')
    assert_equal 'テストユーザー', user1.name_or_email
    assert_equal 'user_2@example.com', user2.name_or_email
  end
end
