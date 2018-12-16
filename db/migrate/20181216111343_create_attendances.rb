class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :performer, foreign_key: true
      t.references :schedule, index: true, foreign_key: true

      t.timestamps
    end
    add_index :attendances, [:performer_id, :schedule_id], unique: true
  end
end
