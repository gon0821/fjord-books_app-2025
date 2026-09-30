# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    author = build(:user)
    guest = build(:user)
    report = build(:report, user: author)
    assert report.editable?(author)
    assert_not report.editable?(guest)
  end

  test '#created_on' do
    report = build(:report, created_at: '2026-09-14 12:00:00')
    assert_equal Date.new(2026, 9, 14), report.created_on
  end

  test '#save_mentions' do
    guest = create(:user)
    author = create(:user)
    guest_report = create(:report, id: 2, user: guest)
    author_report = create(:report, id: 1, user: author, content: <<~TEXT)
      他人の日報: http://localhost:3000/reports/2
      重複分: http://localhost:3000/reports/2
      自分の日報: http://localhost:3000/reports/1
    TEXT

    assert_equal 1, author_report.mentioning_reports.count
    assert_includes author_report.mentioning_reports, guest_report
  end
end
