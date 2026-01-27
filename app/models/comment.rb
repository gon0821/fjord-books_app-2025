# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true

  def own?(current_user)
    user == current_user
  end
end
