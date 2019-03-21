#TODO: テストを書く

module Api
  module V1
    class TodaysArticlesController < Api::V1::BaseController
      def show
        render plain: WeeklyPost.todays_article
      end
    end
  end
end
