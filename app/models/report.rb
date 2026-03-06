# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'ReportMention', foreign_key: :mentioning_report_id, inverse_of: 'mentioning_report', dependent: :destroy
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report, dependent: :destroy

  has_many :passive_mentions, class_name: 'ReportMention', foreign_key: :mentioned_report_id, inverse_of: 'mentioned_report', dependent: :destroy
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_with_mentions
    saved = false
    ActiveRecord::Base.transaction do
      if save
        add_linked_mentions
        saved = true
      else
        raise ActiveRecord::Rollback
      end
    end
    saved
  end

  def update_with_mentions(params)
    updated = false
    ActiveRecord::Base.transaction do
      if update(params)
        add_linked_mentions
        updated = true
      else
        raise ActiveRecord::Rollback
      end
    end
    updated
  end

  def mentioned_link_ids
      content
        .scan(%r{http://localhost:3000/reports/\d+})
        .map { |link| link[/\d+\z/].to_i }
  end

  def add_linked_mentions
    active_mentions.destroy_all
    mentioned_link_ids.each do |mentioned_link_id|
      active_mentions.create!(mentioned_report_id: mentioned_link_id)
    end
  end
end
