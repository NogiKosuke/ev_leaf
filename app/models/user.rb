class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_validation { email.downcase! }
  before_destroy :admin_destroy_check
  after_update :admin_edit_check

  private

  def admin_destroy_check
    number = User.all.where(admin: true).count
    if ( number - 1 == 0) && (self.admin == true)
      throw(:abort)
    end
  end

  def admin_edit_check
    number = User.all.where(admin: true).count
    if  number  == 0
      raise ActiveRecord::Rollback 
    end
  end
end
