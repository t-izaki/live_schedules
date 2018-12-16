module ApplicationHelper
  def replace_if_blank(str, message)
    str.blank? ? message : str
  end

  def ja_week(date)
    arr = %w[日 月 火 水 木 金 土]
    arr[date.wday]
  end
end
