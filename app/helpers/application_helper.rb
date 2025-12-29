module ApplicationHelper
  def weekday_label(date)
    %w[日 月 火 水 木 金 土][date.wday]
  end

  def meal_type_label(meal_type)
    case meal_type.to_s
    when "morning" then "朝"
    when "lunch" then "昼"
    when "dinner" then "晩"
    else meal_type
    end
  end
end
