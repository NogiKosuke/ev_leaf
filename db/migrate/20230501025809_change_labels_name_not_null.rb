class ChangeLabelsNameNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :labels, :lbl_name, false
  end
end
