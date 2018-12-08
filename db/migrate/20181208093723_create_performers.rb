class CreatePerformers < ActiveRecord::Migration[5.2]
  def change
    create_table :performers do |t|
      t.string :name, null: false
      t.text :introduction
      t.references :instrument, index: true

      t.timestamps
    end
  end
end
