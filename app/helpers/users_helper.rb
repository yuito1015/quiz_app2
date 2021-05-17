module UsersHelper
  def icon_for(user, options = { size: 70 })
    image_tag "/icons/#{user.image_name}", class: "rounded-pill", alt: user.name, size: options[:size]
  end
end
