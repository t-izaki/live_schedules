module NotificationHelper
  class << self
    def generate_article_and_performer_ids(text)
      text = convert_days(text)
      text = convert_title(text)
      text, performer_ids = convert_and_get_performers(text)
      [text, performer_ids]
    end

    def convert_days(text)
      text.gsub(/%day(\+\d+?|)%/) { |_text| days_since(Regexp.last_match(1).to_i).day.to_s }
    end

    def days_since(count = 0)
      post_date = Date.today
      post_date.since(count.days)
    end

    def convert_title(text)
      text.gsub(/%title(\+\d+?|)%/) { |_text| Schedule.find_by!(date: days_since(Regexp.last_match(1).to_i)).title }
    end

    def convert_and_get_performers(text)
      performer_ids = []
      text = text.gsub(/%performers(\+\d+?|)%/) do |_text|
        text, ids = convert_performers(Regexp.last_match(1).to_i)
        performer_ids += ids
        text
      end
      [text, performer_ids]
    end

    def convert_performers(count = 0)
      date = days_since(count)
      performers = Schedule.find_by!(date: date).performers
      text = ''
      performer_ids = []
      performers.each do |performer|
        text += performer.instrument_name + '　' + performer.name + "\r\n"
        performer_ids << performer.id
      end
      text = '演奏はありません\n' if text.blank?
      [text, performer_ids]
    end
  end
end
