class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.all
  end

  def show
    @comment = current_user.comments.new
  end

  def new
    @report = current_user.reports.new
  end

  def edit
    return redirect_to reports_path, alert: '自分以外の日報は編集できません' unless @report.user == current_user
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return redirect_to reports_path, alert: '自分以外の日報は編集できません' unless @report.user == current_user
    if @report.update(report_params)
      redirect_to @report, status: :see_other, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return redirect_to reports_path, alert: '自分以外の日報は削除できません' unless @report.user == current_user
    @report.destroy!
    redirect_to reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params.expect(:id))
  end

  def report_params
    params.expect(report: %i[title content target_date])
  end
end
