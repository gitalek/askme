# Модуль хэлпера ApplicationHelper
#
# В этом файле мы можем писать вспомогательные методы (хелперы) для шаблонов,
# (представлений, вьюх) нашего приложения
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть
  # или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # склонятор
  def sklonenie(number, krokodil, krokodila, krokodilov)
    number = 0 unless number.is_a?(Numeric)

    ostatok = if number.to_s.match?(/^([1-9]\d*)?1[1-4]$/)
                number % 100
              else
                number % 10
              end

    return krokodil if ostatok == 1

    return krokodila if ostatok >= 2 && ostatok <= 4

    krokodilov if ostatok > 4 || ostatok.zero?
  end
end