# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, :content, :target_date, presence: true

  def own?(current_user)
    user == current_user
  end
end
