class Report < ApplicationRecord
  belongs_to :user
  validates :title, :content, :target_date, presence: true
end
