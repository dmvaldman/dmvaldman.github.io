module Jekyll
  class WritingPaginationGenerator < Generator
    safe true
    priority :low

    def generate(site)
      posts = site.posts.docs.sort_by { |p| p.date }.reverse
      per_page = 20
      total_pages = (posts.size.to_f / per_page).ceil

      # Generate paginated pages
      (1..total_pages).each do |page_num|
        paginated_posts = posts.slice((page_num - 1) * per_page, per_page)

        if page_num == 1
          # First page uses /writing/
          page = WritingPaginationPage.new(site, site.source, 'writing', page_num, paginated_posts, total_pages)
        else
          # Subsequent pages use /writing/page/N/
          page = WritingPaginationPage.new(site, site.source, File.join('writing', 'page', page_num.to_s), page_num, paginated_posts, total_pages)
        end

        site.pages << page
      end
    end
  end

  class WritingPaginationPage < Page
    def initialize(site, base, dir, page_num, posts, total_pages)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'writing.html')

      self.data['posts'] = posts
      self.data['page_num'] = page_num
      self.data['total_pages'] = total_pages
      self.data['title'] = 'Writing'

      if page_num == 1
        self.data['permalink'] = '/writing/'
      else
        self.data['permalink'] = "/writing/page/#{page_num}/"
      end
    end
  end
end
