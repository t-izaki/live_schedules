class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :date, null: false
      t.integer :state, null: false, default: 0
      t.string :title
      t.text :detail

      t.timestamps
    end
    add_index :schedules, :date, unique: true
  end
end
