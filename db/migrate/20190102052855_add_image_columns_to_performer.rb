class AddImageColumnsToPerformer < ActiveRecord::Migration[5.2]
  def change
    add_column :performers, :image_url, :text, after: :introduction
    add_column :performers, :icon_url, :text, after: :introduction
  end
end
