module ApplicationHelper
  def user_avatar(user)
    return asset_path 'avatar.jpg' unless user.avatar_url.present?
    user.avatar_url
  end

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


