# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "日報作成者は編集できること" do
    naoki = users(:naoki)
    report = reports(:naoki_report_one)
    assert report.editable?(naoki)
  end

  test "日報作成者以外はを編集できないこと" do
    armin = users(:armin)
    report = reports(:naoki_report_one)
    assert_not report.editable?(armin)
  end

  test "Date型を返すこと" do
    report = reports(:naoki_report_one)
    assert_equal Date.new(2026, 9, 14), report.created_on
  end

  test "日報保存時、日報内で言及している他の日報が正しく記録されること" do
    report = reports(:naoki_report_one)
    report.save
    assert_equal [2,3], report.mentioning_reports.map(&:id)
  end

end
