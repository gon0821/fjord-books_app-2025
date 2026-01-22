# frozen_string_literal: true

class ReportCommentsController < CommentsController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @report = Report.find(params[:report_id])
      @comments = @report.comments
      render 'reports/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.expect(comment: [:content]).merge(
      user_id: current_user.id,
      commentable_id: params[:report_id],
      commentable_type: 'Report'
    )
  end
end
