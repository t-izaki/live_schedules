class WeeklyPost < ApplicationRecord
  enum week: { Sunday: 0, Monday: 1, Tuesday: 2, Wednesday: 3, Thursday: 4, Friday: 5, Saturday: 6 }

  validates :week, inclusion: { in: WeeklyPost.weeks.keys }

  def self.todays_article
    if Schedule.today.open?
      weekly_post = find_by(week: Time.zone.today.wday)
      weekly_post.convert_placeholder
    else
      ''
    end
  end

  def convert_placeholder
    converted_article = template_article
    converted_article = convert_days(converted_article)
    converted_article = convert_title(converted_article)
    converted_article = convert_performers(converted_article)

    converted_article
  end

  private

  def convert_days(text)
    text.gsub(/%day(\+\d+?|)%/) { |_text| days_since(Regexp.last_match(1).to_i).day.to_s }
  end

  def days_since(count = 0)
    post_date = Time.zone.today
    post_date.since(count.days)
  end

  def convert_title(text)
    text.gsub(/%title(\+\d+?|)%/) { |_text| Schedule.find_by!(date: days_since(Regexp.last_match(1).to_i)).title }
  end

  def convert_performers(text)
    text.gsub(/%performers(\+\d+?|)%/) { |_text| performer_and_instrument(Regexp.last_match(1).to_i) }
  end

  def performer_and_instrument(count = 0)
    date = days_since(count)
    performers = Schedule.find_by!(date: date).performers
    text = ''
    performers.each do |performer|
      text += performer.instrument_name + '　' + performer.name + "\r\n"
    end

    text || "演奏はありません\r\n"
  end
end
