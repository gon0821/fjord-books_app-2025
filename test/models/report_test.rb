# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    naoki = users(:naoki)
    armin = users(:armin)
    report = reports(:naoki_report_one)
    assert report.editable?(naoki)
    assert_not report.editable?(armin)
  end

  test '#created_on' do
    report = reports(:naoki_report_one)
    assert_equal Date.new(2026, 9, 14), report.created_on
  end

  test '#save_mentions' do
    report = reports(:naoki_report_one)
    report.save
    assert_equal [2, 3], report.mentioning_reports.map(&:id)
  end
end
