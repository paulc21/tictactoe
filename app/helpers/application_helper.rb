module ApplicationHelper

  def xo_image(xo)
    if xo == "X"
      image_tag "x.png"
    elsif
      xo == "O"
      image_tag "o.png"
    end
  end

end
