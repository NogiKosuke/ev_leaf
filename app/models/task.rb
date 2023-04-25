class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :expired_at, presence: true
  scope :title_like, -> (title){ where('title like ?', "%#{title}%") }
  scope :status_where, -> (status){ where('status like ?', "#{status}") }
  enum priority: { '高': 0, '中': 1 , '低': 2 }
  belongs_to :user
end
