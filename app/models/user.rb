# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :icon do |attachable|
    attachable.variant :thumb, resize_to_limit: [120, 120]
  end
end
