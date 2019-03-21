module Setting
  class WeeklyPostsController < ApplicationController
    def edit
      @weekly_posts = WeeklyPost.all
    end

    def update
      ActiveRecord::Base.transaction do
        update_params.each do |id, attr|
          post = WeeklyPost.find(id)
          post.update!(attr)
        end
      end
      redirect_to edit_setting_weekly_posts_path, notice: '投稿の更新に成功しました'
    end

    private

    def update_params
      params.permit(weekly_posts: [:template_article])[:weekly_posts]
    end
  end
end
