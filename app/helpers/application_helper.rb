module ApplicationHelper
  def full_title(page_title = "")
    base_title = "OnePieceQuiz"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def icon_for(user, options = { size: 70 })
    image_tag "/icons/#{user.image_name}", class: "rounded-pill", alt: user.name, size: options[:size]
  end
end
