module TextbooksHelper

  # Returns the image for a given textbook
  def cover_image_for(textbook)
    if textbook.image?
      image_tag(textbook.image.url(:thumb))
    else
      image_tag('no_image_found.jpg', width: 200)
    end
  end
end
