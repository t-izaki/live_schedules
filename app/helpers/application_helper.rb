module ApplicationHelper
  def replace_if_blank(str, message)
    str.blank? ? message : str
  end
end
