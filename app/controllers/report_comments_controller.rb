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
end
