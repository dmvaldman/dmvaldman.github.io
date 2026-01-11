module Jekyll
  class CollectionPaginationGenerator < Generator
    safe true
    priority :lowest

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
      archived_projects = site.collections['projects'].docs.reject { |p| p.data['status'] == 'current' }

      all_items = (site.posts.docs + current_projects + archived_projects).sort_by do |i|
        if i.data['status'] == 'current'
          Time.new(9999, 1, 1)
        else
          i.date
        end
      end.reverse

      per_page = site.config['paginate'] || 10
      total_pages = (all_items.size.to_f / per_page).ceil
      current_count = [current_projects.size, per_page].min

      (1..total_pages).each do |page_num|
        paginated_items = all_items.slice((page_num - 1) * per_page, per_page)
        dir = page_num == 1 ? '' : File.join('page', page_num.to_s)
        permalink = page_num == 1 ? '/' : "/page/#{page_num}/"

        page = create_page(site, dir, 'home_paginated.html', {
          'items' => paginated_items,
          'page_num' => page_num,
          'total_pages' => total_pages,
          'current_count' => page_num == 1 ? current_count : 0,
          'title' => 'Home',
          'permalink' => permalink
        })
        site.pages << page
      end

      site.pages.reject! { |p| p.name == 'index.html' && p.dir == '/' && p.data['layout'] == 'home' }
    end

    def generate_writing_pages(site)
      posts = site.posts.docs.sort_by { |p| p.date }.reverse
      per_page = 20
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
      per_page = 20
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
      page = Page.new(site, site.source, dir, 'index.html')
      page.process('index.html')
      page.read_yaml(File.join(site.source, '_layouts'), layout)
      data.each { |key, value| page.data[key] = value }
      page
    end
  end
end
