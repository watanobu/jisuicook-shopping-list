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

  def format_quantity(number)
    return "" if number.nil?
    # 小数部が 0 のときは整数表示、それ以外は少数2桁まで
    rounded = number.to_d
    if rounded.frac.zero?
      rounded.to_i
    else
      number_with_precision(rounded, precision: 2).sub(/\.?0+$/, "")
    end
  end
end
