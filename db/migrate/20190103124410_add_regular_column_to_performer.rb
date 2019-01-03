class AddRegularColumnToPerformer < ActiveRecord::Migration[5.2]
  def change
    add_column :performers, :regular, :boolean, after: :introduction, null: false, default: false
  end
end
