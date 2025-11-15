# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [120, 120]
  end
  validate :allowed_image_formats

  private
  def allowed_image_formats
    if icon.attached? && !icon.content_type.match?(/image\/(jpeg|png|gif)/)
      errors.add(:icon, 'が正しい画像形式ではありません')
    end
  end
end
