class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, presence: true
  validates :expired_at, presence: true
  scope :title_like, -> (title){
    return  if title.blank?
    where('title like ?', "%#{title}%") 
  }
  scope :status_where, -> (status){
    return if status.blank?
    where('status like ?', "#{status}") 
  }
  scope :tasks_label_where, -> (label_id){ 
    return if label_id.blank?
    where(id: Stick.where(label_id: label_id).select(:task_id)) 
  }
  scope :paginate, ->(p) { page(p[:page]).per(15) }
  scope :latest, -> { order(created_at: :desc) }
  scope :sort_limit, -> { order(expired_at: :asc) }
  scope :sort_priority, -> { order(priority: :asc) }
  enum priority: { '高': 0, '中': 1 , '低': 2 }
  belongs_to :user
  has_many :sticks, dependent: :destroy
  has_many :labels, through: :sticks
end
