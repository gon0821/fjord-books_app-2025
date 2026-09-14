# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "名前の登録があるとき、名前が返されること" do
    naoki = users(:naoki)
    assert_equal 'naoki', naoki.name_or_email
  end

  test "名前の登録がないとき、メールアドレスが返されること" do
    eren = users(:eren)
    assert_equal 'eren@example.com', eren.name_or_email
  end
end
