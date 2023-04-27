class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :lbl_name

      t.timestamps
    end
  end
end
