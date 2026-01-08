module Jekyll
  class PhotographyPaginationGenerator < Generator
    safe true
    priority :low

    def generate(site)
      albums = site.collections['photography'].docs.sort_by { |a| a.data['order'] || 0 }

      # Create the photography page
      page = PhotographyPaginationPage.new(site, site.source, 'photos', albums)
      site.pages << page
    end
  end

  class PhotographyPaginationPage < Page
    def initialize(site, base, dir, albums)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'photography.html')

      self.data['albums'] = albums
      self.data['title'] = 'Photos'
      self.data['permalink'] = '/photos/'
    end
  end
end
