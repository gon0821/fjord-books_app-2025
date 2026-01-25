# frozen_string_literal: true

class ReportCommentsController < CommentsController
  def render_commentable_show
    @report = Report.find(params[:report_id])
    @comments = @report.comments
    render 'reports/show', status: :unprocessable_entity
  end

  private

  def commentable_params
    { commentable_id: params[:report_id], commentable_type: 'Report' }
  end
end
