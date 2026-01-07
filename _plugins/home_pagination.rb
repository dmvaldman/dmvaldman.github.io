module Jekyll
  class HomePaginationGenerator < Generator
    safe true
    priority :lowest  # Run after other generators

    def generate(site)
      # Get all posts and projects, sorted by date
      all_items = (site.posts.docs + site.collections['projects'].docs).sort_by { |i| i.date }.reverse
      per_page = site.config['paginate'] || 10
      total_pages = (all_items.size.to_f / per_page).ceil

      # Generate paginated home pages
      (1..total_pages).each do |page_num|
        paginated_items = all_items.slice((page_num - 1) * per_page, per_page)

        if page_num == 1
          # First page replaces index.html
          page = HomePaginationPage.new(site, site.source, '', page_num, paginated_items, total_pages)
        else
          # Subsequent pages use /page/N/
          page = HomePaginationPage.new(site, site.source, File.join('page', page_num.to_s), page_num, paginated_items, total_pages)
        end

        site.pages << page
      end

      # Remove the original index.html that jekyll-paginate created
      site.pages.reject! { |p| p.name == 'index.html' && p.dir == '/' && p.data['layout'] == 'home' }
    end
  end

  class HomePaginationPage < Page
    def initialize(site, base, dir, page_num, items, total_pages)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'home_paginated.html')

      self.data['items'] = items
      self.data['page_num'] = page_num
      self.data['total_pages'] = total_pages
      self.data['title'] = 'Home'

      if page_num == 1
        self.data['permalink'] = '/'
      else
        self.data['permalink'] = "/page/#{page_num}/"
      end
    end
  end
end
