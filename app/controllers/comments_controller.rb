class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    case @comment.commentable_type
    when "Report"
      @report = Report.find(comment_params[:commentable_id])
      @comments = @report.comments
    when "Book"
      @book = Book.find(comment_params[:commentable_id])
      @comments = @book.comments
    end

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render "#{comment_params[:commentable_type].downcase.pluralize}/show", status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.expect(comment: [:content, :commentable_id, :commentable_type]).merge(user_id: current_user.id)
  end
end
