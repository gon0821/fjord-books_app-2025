# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "#name_or_email" do
    naoki = users(:naoki)
    eren = users(:eren)
    assert_equal 'naoki', naoki.name_or_email
    assert_equal 'eren@example.com', eren.name_or_email
  end
end
