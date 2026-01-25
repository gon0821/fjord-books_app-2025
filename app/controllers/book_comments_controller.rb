# frozen_string_literal: true

class BookCommentsController < CommentsController
  def render_commentable_show
    @book = Book.find(params[:book_id])
    @comments = @book.comments
    render 'books/show', status: :unprocessable_entity
  end

  private

  def commentable_params
    { commentable_id: params[:book_id], commentable_type: 'Book' }
  end
end
