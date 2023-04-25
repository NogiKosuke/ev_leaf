class ChangeTasksExpiredAtNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :expired_at, false, "#{7.day.from_now}"
  end
end
