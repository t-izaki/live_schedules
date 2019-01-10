require "#{Rails.root}/lib/tasks/notification_helper"
require 'net/http'
require 'uri'

# rubocop:disable Metrics/BlockLength
# TODO: テストを書く
namespace :notification do
  desc 'スケジュールを毎日投稿する'
  task facebook_post: :environment do
    # 記事の取得
    post_date = Date.today
    plain_article = WeeklyPost.find_by!(week: post_date.wday).article
    if plain_article.blank?
      puts '投稿する記事がありません'
      next
    end
    article, performer_ids = NotificationHelper.generate_article_and_performer_ids(plain_article)
    p article

    # 演奏者の画像の投稿
    media_fbids = {}
    performer_ids.each_with_index do |performer_id, i|
      image_url = Performer.find(performer_id).image_url
      next if image_url.blank?

      res = Net::HTTP.post_form(
        URI.parse("https://graph.facebook.com/v3.2/#{ENV.fetch('FACEBOOK_PAGE_ID')}/photos"),
        'url': image_url,
        'published': false,
        'access_token': ENV.fetch('FACEBOOK_PAGE_ACCESS_TOKEN')
      )
      puts res.body
      media_fbids["attached_media[#{i}]"] = "{ 'media_fbid': #{JSON.parse(res.body)['id']} }"
    end

    # 記事の投稿
    res = Net::HTTP.post_form(
      URI.parse("https://graph.facebook.com/v3.2/#{ENV.fetch('FACEBOOK_PAGE_ID')}/feed"), {
        'message': article,
        'access_token': ENV.fetch('FACEBOOK_PAGE_ACCESS_TOKEN')
      }.merge(media_fbids)
    )
    puts res.body
  end
end
# rubocop:enable Metrics/BlockLength
