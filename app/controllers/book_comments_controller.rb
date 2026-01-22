# frozen_string_literal: true

class BookCommentsController < CommentsController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @book = Book.find(params[:book_id])
      @comments = @book.comments
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.expect(comment: [:content]).merge(
      user_id: current_user.id,
      commentable_id: params[:book_id],
      commentable_type: 'Book'
    )
  end
end
