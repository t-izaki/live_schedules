class AddForeignKeyToPerformer < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :performers, :instruments
  end
end
