class Label < ApplicationRecord
  has_many :sticks, dependent: :destroy
  has_many :tasks, through: :sticks
end
