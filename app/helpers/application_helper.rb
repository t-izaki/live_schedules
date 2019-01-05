module ApplicationHelper
  def replace_if_blank(str, message)
    str.blank? ? message : str
  end

  def ja_week(date)
    arr = %w[日 月 火 水 木 金 土]
    arr[date.wday]
  end

  def nav_item_class(controller_path = '')
    ['nav-item', 'nav-link', active_or_blank(controller_path)].reject(&:blank?).join(' ')
  end

  def list_group_item_class(controller_path = '')
    ['list-group-item', 'list-group-item-action', active_or_blank(controller_path)].reject(&:blank?).join(' ')
  end

  private

  def active_or_blank(controller_path)
    if controller.controller_path.include?(controller_path)
      'active'
    else
      ''
    end
  end
end
