Jekyll::Hooks.register [:documents, :pages], :post_render do |item|
  next unless item.output_ext == '.html'

  item.output = item.output.gsub(
    %r{<p>(\s*(?:<a\b[^>]*>\s*)?<img\b[^>]*>\s*(?:</a>\s*)?)<em>(.*?)</em>\s*</p>}m,
    "<p>\\1</p>\n<div class=\"image-caption\">\\2</div>"
  )

  item.output = item.output.gsub(
    %r{(<div class="image-grid(?:\s[^"]*)?">.*?</div>)\s*<p><em>(.*?)</em></p>}m,
    "\\1\n<div class=\"image-caption\">\\2</div>"
  )
end
