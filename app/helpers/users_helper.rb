module UsersHelper

  # Returns the avatar for the given user.
  def avatar_for(user, options = { size: 80 })
    size = options[:size]
    if user.avatar?
      if size <= 50
        image_tag(user.avatar.url(:small_thumb), width: size, height: size, alt: user.name, class: 'avatar')
      else
        image_tag(user.avatar.url(:thumb), width: size, height: size, alt: user.name, class: 'avatar')
      end
    else
      image_tag('default_avatar.jpg', alt: 'avatar image', width: size, height: size, class: 'avatar')
    end
  end
end
