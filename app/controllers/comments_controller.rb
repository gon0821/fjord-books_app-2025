# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :redirect_unless_owner, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render_commentable_show
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, status: :see_other, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = Comment.find(params.expect(:id))
  end

  def comment_params
    params.expect(comment: [:content]).merge(user_id: current_user.id).merge(commentable_params)
  end

  def redirect_unless_owner
    redirect_to @comment.commentable, alert: t('controllers.common.alert_permission', name: Comment.model_name.human) unless @comment.own?(current_user)
  end
end
