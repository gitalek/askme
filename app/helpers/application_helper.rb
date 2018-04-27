module ApplicationHelper
  def user_avatar(user)
    return asset_path 'avatar.jpg' unless user.avatar_url.present?
    user.avatar_url
  end
end
