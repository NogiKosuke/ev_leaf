class CreateSticks < ActiveRecord::Migration[6.1]
  def change
    create_table :sticks do |t|
      t.references :task, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
