class Label < ApplicationRecord
  validates :title, presence: true, length: { maximum: 15 }
  has_many :sticks, dependent: :destroy
  has_many :tasks, through: :sticks
end
