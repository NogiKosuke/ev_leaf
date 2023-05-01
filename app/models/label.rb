class Label < ApplicationRecord
  validates :lbl_name, presence: true, length: { maximum: 15 }
  has_many :sticks, dependent: :destroy
  has_many :tasks, through: :sticks
end
