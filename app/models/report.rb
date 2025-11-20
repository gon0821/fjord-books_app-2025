class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  validates :title, :content, :target_date, presence: true
end
