module ImageCaptions
  def image_captions(html)
    return html unless html

    html = html.gsub(
      %r{<p>(\s*(?:<a\b[^>]*>\s*)?<img\b[^>]*>\s*(?:</a>\s*)?)<em>(.*?)</em>\s*</p>}m,
      "<p>\\1<span class=\"image-caption\">\\2</span></p>"
    )

    html.gsub(
      %r{(<(div|p)\b[^>]*class="[^"]*\bimage-grid\b[^"]*"[^>]*>.*?</\2>)\s*<p><em>(.*?)</em></p>}m,
      "\\1\n<div class=\"image-caption\">\\3</div>"
    )
  end
end

Liquid::Template.register_filter(ImageCaptions)
