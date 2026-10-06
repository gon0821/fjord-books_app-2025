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
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    author = create(:user)
    user1_report = create(:report, id: 1, user: user1)
    user2_report = create(:report, id: 2, user: user2)
    user3_report = create(:report, id: 3, user: user3)
    author_report = create(:report, id: 99, user: author, content: <<~TEXT)
      保持されるの日報: http://localhost:3000/reports/1
      重複分の日報: http://localhost:3000/reports/1
      自分の日報: http://localhost:3000/reports/99
      削除される日報: http://localhost:3000/reports/2
    TEXT

    assert_equal 2, author_report.mentioning_reports.count
    assert_includes author_report.mentioning_reports, user1_report
    assert_includes author_report.mentioning_reports, user2_report

    author_report.update(content: <<~TEXT)
      保持されるの日報: http://localhost:3000/reports/1
      重複分の日報: http://localhost:3000/reports/1
      自分の日報: http://localhost:3000/reports/99
      追加される日報: http://localhost:3000/reports/3
    TEXT

    author_report.reload
    assert_equal 2, author_report.mentioning_reports.count
    assert_includes author_report.mentioning_reports, user1_report
    assert_not_includes author_report.mentioning_reports, user2_report
    assert_includes author_report.mentioning_reports, user3_report
  end
end
