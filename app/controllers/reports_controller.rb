# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    @mentioned_reports = @report.mentioned_reports
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      add_report_mentions(@report)
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      add_report_mentions(@report)
      delete_report_mentions(@report)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!

    redirect_to reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.expect(report: %i[user_id title content])
  end

  def add_report_mentions(report)
    report_links = report.content.scan(/http:\/\/localhost:3000\/reports\/\d+/)
    if report_links
      report_links.each do |link|
        ReportMention.find_or_create_by(mentioning_report_id: report.id, mentioned_report_id: link[/\d+\z/].to_i)
      end
    end
  end

  def delete_report_mentions(report)
    report_links = report.content.scan(/http:\/\/localhost:3000\/reports\/\d+/)
    reports = []
    report_links.each do |link|
      reports << Report.find(link[/\d+\z/].to_i)
    end
    diff_reports = report.mentioning_reports - reports
    diff_reports.each do |diff_report|
      report.active_mentions.find_by(mentioned_report_id: diff_report.id).delete
    end
  end
end
