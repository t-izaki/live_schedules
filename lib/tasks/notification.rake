require "#{Rails.root}/lib/tasks/notification_helper"

namespace :notification do
  desc 'スケジュールを毎日投稿する'
  task facebook_post: :environment do
    week = Date.today.wday
    plain_article = WeeklyPost.find_by!(week: week).article
    article = NotificationHelper.convert_placeholder(plain_article)

    p article

    # TODO: post_article
  end
end
