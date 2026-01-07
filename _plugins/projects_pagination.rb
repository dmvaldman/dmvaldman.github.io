module Jekyll
  class ProjectsPaginationGenerator < Generator
    safe true
    priority :low

    def generate(site)
      projects = site.collections['projects'].docs.sort_by { |p| p.date }.reverse
      per_page = 20
      total_pages = (projects.size.to_f / per_page).ceil

      # Generate paginated pages
      (1..total_pages).each do |page_num|
        paginated_projects = projects.slice((page_num - 1) * per_page, per_page)

        if page_num == 1
          # First page uses /projects/
          page = ProjectsPaginationPage.new(site, site.source, 'menu', page_num, paginated_projects, total_pages)
        else
          # Subsequent pages use /projects/page/N/
          page = ProjectsPaginationPage.new(site, site.source, File.join('projects', 'page', page_num.to_s), page_num, paginated_projects, total_pages)
        end

        site.pages << page
      end
    end
  end

  class ProjectsPaginationPage < Page
    def initialize(site, base, dir, page_num, projects, total_pages)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'projects.html')

      self.data['projects'] = projects
      self.data['page_num'] = page_num
      self.data['total_pages'] = total_pages
      self.data['title'] = 'Projects'

      if page_num == 1
        self.data['permalink'] = '/projects/'
      else
        self.data['permalink'] = "/projects/page/#{page_num}/"
      end
    end
  end
end
