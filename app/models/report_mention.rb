# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :mentioning_report, class_name: 'Report'
  belongs_to :mentioned_report, class_name: 'Report'

  def self.add_linked_mentions(report)
    report.mentioned_link_ids.each do |mentioned_link_id|
      find_or_create_by!(mentioning_report_id: report.id, mentioned_report_id: mentioned_link_id)
    end
  end

  def self.remove_unlinked_mentions(report)
    diff_report_ids = report.mentioning_reports.map(&:id) - report.mentioned_link_ids
    diff_report_ids.each do |diff_report_id|
      report.active_mentions.find_by(mentioned_report_id: diff_report_id).destroy!
    end
  end
end
