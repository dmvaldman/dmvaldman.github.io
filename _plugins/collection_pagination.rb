module Jekyll
  class CollectionPaginationGenerator < Generator
    safe true
    priority :low

    def generate(site)
      # Home page with mixed posts and projects
      generate_home_pages(site)

      # Writing pages (posts only)
      generate_writing_pages(site)

      # Projects pages
      generate_projects_pages(site)

      # Photography page
      generate_photography_page(site)
    end

    private

    def generate_home_pages(site)
      current_projects = site.collections['projects'].docs.select { |p| p.data['status'] == 'current' }.sort_by { |p| p.data['order'] || 0 }
      archived_projects = site.collections['projects'].docs.reject { |p| p.data['status'] == 'current' }.sort_by { |p| p.data['date'] || Time.now }.reverse
      all_projects = current_projects + archived_projects

      posts = site.collections['writing'].docs.sort_by { |p| p.data['date'] || Time.now }.reverse

      projects_per_page = site.config.dig('pagination', 'projects') || 10
      writing_per_page = site.config.dig('pagination', 'writing') || 10

      projects_total_pages = (all_projects.size.to_f / projects_per_page).ceil
      writing_total_pages = (posts.size.to_f / writing_per_page).ceil
      total_pages = [projects_total_pages, writing_total_pages].max

      (1..total_pages).each do |page_num|
        paginated_projects = all_projects.slice((page_num - 1) * projects_per_page, projects_per_page) || []
        paginated_posts = posts.slice((page_num - 1) * writing_per_page, writing_per_page) || []

        dir = page_num == 1 ? '' : File.join('page', page_num.to_s)
        permalink = page_num == 1 ? '/' : "/page/#{page_num}/"

        page = create_page(site, dir, 'home.html', {
          'projects' => paginated_projects,
          'posts' => paginated_posts,
          'page_num' => page_num,
          'total_pages' => total_pages,
          'projects_total_pages' => projects_total_pages,
          'writing_total_pages' => writing_total_pages,
          'current_count' => page_num == 1 ? current_projects.size : 0,
          'title' => 'Home',
          'permalink' => permalink
        })
        site.pages << page
      end

      site.pages.reject! { |p| p.name == 'index.html' && p.dir == '/' && p.data['layout'] == 'home' }
    end

    def generate_writing_pages(site)
      posts = site.collections['writing'].docs.sort_by { |p| p.data['date'] || Time.now }.reverse
      per_page = site.config.dig('pagination', 'writing') || 10
      total_pages = (posts.size.to_f / per_page).ceil

      (1..total_pages).each do |page_num|
        paginated_posts = posts.slice((page_num - 1) * per_page, per_page)
        dir = page_num == 1 ? 'writing' : File.join('writing', 'page', page_num.to_s)
        permalink = page_num == 1 ? '/writing/' : "/writing/page/#{page_num}/"

        page = create_page(site, dir, 'writing.html', {
          'posts' => paginated_posts,
          'page_num' => page_num,
          'total_pages' => total_pages,
          'title' => 'Writing',
          'permalink' => permalink
        })
        site.pages << page
      end
    end

    def generate_projects_pages(site)
      all_projects = site.collections['projects'].docs
      current_projects = all_projects.select { |p| p.data['status'] == 'current' }.sort_by { |p| p.data['order'] || 0 }
      archived_projects = all_projects.reject { |p| p.data['status'] == 'current' }.sort_by { |p| p.date }.reverse

      projects = current_projects + archived_projects
      per_page = site.config.dig('pagination', 'projects') || 10
      total_pages = (projects.size.to_f / per_page).ceil

      (1..total_pages).each do |page_num|
        paginated_projects = projects.slice((page_num - 1) * per_page, per_page)
        has_current = page_num == 1 && current_projects.size > 0
        current_count = has_current ? [current_projects.size, per_page].min : 0

        dir = page_num == 1 ? 'menu' : File.join('projects', 'page', page_num.to_s)
        permalink = page_num == 1 ? '/projects/' : "/projects/page/#{page_num}/"

        page = create_page(site, dir, 'projects.html', {
          'projects' => paginated_projects,
          'page_num' => page_num,
          'total_pages' => total_pages,
          'current_count' => current_count,
          'title' => 'Projects',
          'permalink' => permalink
        })
        site.pages << page
      end
    end

    def generate_photography_page(site)
      albums = site.collections['photography'].docs.sort_by { |a| a.data['order'] || 0 }

      page = create_page(site, 'photos', 'photography.html', {
        'albums' => albums,
        'title' => 'Photos',
        'permalink' => '/photos/'
      })
      site.pages << page
    end

    def create_page(site, dir, layout, data)
      page = PaginationPage.new(site, site.source, dir, layout, data)
      page
    end
  end

  class PaginationPage < Page
    def initialize(site, base, dir, layout, data)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), layout)

      data.each { |key, value| self.data[key] = value }
    end
  end
end
