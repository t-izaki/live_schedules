module NotificationHelper
  class << self
    def convert_placeholder(text)
      text = convert_days(text)
      text = convert_performers(text)
      text
    end

    def convert_days(text)
      text.gsub(/%day(\+\d+?|)%/) { |_text| days_since(Regexp.last_match(1).to_i).day.to_s }
    end

    def days_since(count = 0)
      Date.today.since(count.days)
    end

    def convert_performers(text)
      text.gsub(/%performers(\+\d+?|)%/) { |_text| performers(Regexp.last_match(1).to_i) }
    end

    def performers(count = 0)
      date = days_since(count)
      performers = Schedule.find_by!(date: date).performers
      text = ''
      performers.each do |performer|
        text += performer.instrument_name + '　' + performer.name + '\r\n'
      end
      text.present? ? text : '演奏はありません'
    end
  end
end
