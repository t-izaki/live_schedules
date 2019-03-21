class RenameArticleToWeeklyPost < ActiveRecord::Migration[5.2]
  def change
    change_table :weekly_posts do |t|
      t.rename :article, :template_article
    end
  end
end
