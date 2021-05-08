module UsersHelper
  def icon_for(user, options = { size: 70 })
    image_tag("/icons/#{user.image_name}", alt: user.name, class: "rounded-pill", size: options[:size])
  end
end
