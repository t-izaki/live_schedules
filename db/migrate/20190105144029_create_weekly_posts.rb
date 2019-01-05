class CreateWeeklyPosts < ActiveRecord::Migration[5.2]
  def up
    create_table :weekly_posts do |t|
      t.integer :week, null: false
      t.text :article

      t.timestamps
    end
    add_index :weekly_posts, :week, unique: true

    WeeklyPost.create(week: 0)
    WeeklyPost.create(week: 1)
    WeeklyPost.create(week: 2)
    WeeklyPost.create(week: 3)
    WeeklyPost.create(week: 4)
    WeeklyPost.create(week: 5)
    WeeklyPost.create(week: 6)
  end

  def down
    drop_table :weekly_posts
  end
end
