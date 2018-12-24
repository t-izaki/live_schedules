module ApplicationHelper
  def replace_if_blank(str, message)
    str.blank? ? message : str
  end

  def ja_week(date)
    arr = %w[日 月 火 水 木 金 土]
    arr[date.wday]
  end

  def nav_item_class(controller_name = '')
    ['nav-item', 'nav-link', active_or_blank(controller_name)].reject(&:blank?).join(' ')
  end

  private

  def active_or_blank(controller_name)
    if controller.controller_name == controller_name
      'active'
    else
      ''
    end
  end
end
