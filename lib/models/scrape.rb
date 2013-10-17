class ItemScraper
  attr_accessor :doc
  # a single student page

  @@apology = "[Sorry, there was a problem with the formatting of this section - sincerely, The Scrapers]"

  def initialize(url)
    begin
    @doc = Nokogiri::HTML(open(url))
    rescue
      "rescued!"
    end
  end

  def name
    begin
    @doc.css(".ib_main_header").children.text
    rescue
      @@apology
    end
  end

  def twitter
    begin
    @doc.css(".social-icons a")[0].attr('href')
    rescue
      @@apology
    end
  end

  def linkedin
    begin
    @doc.css(".social-icons a")[1].attr('href')
    rescue
      @@apology
    end
  end

  def github
    begin
    @doc.css(".social-icons a")[2].attr('href')
    rescue
      @@apology
    end
  end

  def radar
    begin
    @doc.css(".social-icons a")[3].attr('href')
    rescue
      @@apology
    end
  end
  # this is the "rss"/facebook link.

  def quote
    begin
    @doc.css(".textwidget").text.strip
    rescue
      @@apology
    end
  end

  def bio
    begin
    @doc.css("#ok-text-column-2 .services p").first.content.gsub("\n","")
    rescue
      @@apology
    end
  end

  def education
    begin
    all_education = @doc.css("#ok-text-column-3 .services ul li").collect do |
        school|
      school.content
    end
    rescue
      @@apology
    end
  end
    #=> returns array of school names

  def work
    # getting truncated/comibing with flatiron projects
    begin
    @doc.css("#ok-text-column-4 .services p").children[0].text.gsub("\n","")
    rescue
      @@apology
    end
  end

  def blogs
    begin
    all_blogs = @doc.css("#ok-text-column-3 .services p")[0].css("a").collect do |
        blog|
      blog.attr('href')
    end
    rescue
      @@apology
    end
  end
    #=> returns an array of blog links

  def github_cred
    begin
    @doc.css(".coder-cred")[0].children.children[1].attr('href')
    rescue
      @@apology
    end
  end

  def treehouse_cred
    begin
    @doc.css(".coder-cred")[0].children.children[4].attr('href')
    rescue
      @@apology
    end
  end

  def codeschool_cred
    begin
    @doc.css(".coder-cred")[0].children.children[7].attr('href')
    rescue
      @@apology
    end
  end

  def coderwall_cred
    begin
    @doc.css(".coder-cred")[0].children.children[10].attr('href')
    rescue
      @@apology
    end
  end

  def favorite_website
    # out of order? top getting popped off?
    begin
    @doc.css("#ok-text-column-3 .services p").children[10].attr('href')
    rescue
      @@apology
    end
  end

  def favorite_comic
    # out of order? top getting popped off?
    begin
    @doc.css("#ok-text-column-3 .services p").children[13].attr('href')
    rescue
      @@apology
    end
  end

  def favorite_podcast
    # out of order? top getting popped off?
    begin
    @doc.css("#ok-text-column-3 .services p").children[16].attr('href')
    rescue
      @@apology
    end
  end

  def flatiron_projects
    # combining with Work
    begin
    @doc.css("#ok-text-column-4 .services p").children[1].text
    rescue
      @@apology
    end
  end

  def coding_profiles
    begin
    all_links = @doc.css('#ok-text-column-2 .services p')[1].css('a').collect do |
        link|
      link.attr('href')
    end
    rescue
      @@apology
    end
  end
    #=> returns array of site links

  def personal_projects
    # blank
    begin
    @doc.css('#ok-text-column-4 .services p')[3].content
    rescue
      @@apology
    end
  end

  def favorite_cities
    # blank
    begin
    all_cities = @doc.css('#ok-text-column-2 .services p')[2].css("a").collect do |city|
      city.text
    end
    rescue
      @@apology
    end
  end
    #=> returns array of cities

end


class IndexScraper
  attr_accessor :doc

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def get_student_urls
    url_array =  @doc.css(".big-comment").collect do |link|
      "#{URL}/#{link.children.children.css('a').attr('href').text}"
    end
    url_array
  end
  
  def build_index_hash
    hash = {}
    frontpage = self.doc.css(".home-blog-post")

    name = self.doc.map do |student|
      student.css("big-comment").text.strip
    end

    photo_urls = frontpage.map do |student|
      student.css(".prof-image").attr("src").to_s
    end

    taglines = frontpage.map do |student|
      student.css(".home-blog-post-meta").text
    end

    blurbs = frontpage.map do |student|
      student.css(".excerpt p").text.squeeze(' ')
    end

    hash[:photo_urls] = photo_urls
    hash[:taglines] = taglines
    hash[:blurbs] = blurbs
    hash
  end
end

class Scrape
  attr_accessor :students, :index_scraper

  def initialize
    @index_scraper = IndexScraper.new(URL)
    @array = @index_scraper.get_student_urls 
    @students = []
  end

  def pic_transform(object, data)
    puts "---------------------"
    puts "the pic info for #{object.name}"
    puts data[:pic_names][:face]
    puts data[:pic_names][:bg]
    puts "----------------------"
    system("cp _site/img/students/#{data[:pic_names][:face]} _site/img/students/#{object.name.downcase.gsub(/\s|'/, '_')}_profile.jpg")
    system("cp _site/img/students/#{data[:pic_names][:bg]} _site/img/students/#{object.name.downcase.gsub(/\s|'/, '_')}_background.jpg")
  end




  def page_scrape(a_url)
      a = ItemScraper.new(a_url)

      s = Student.new
      s.name = a.name
      s.favorite_comic = a.favorite_comic
      s.twitter = a.twitter
      s.linkedin = a.linkedin
      s.github = a.github
      s.radar = a.radar
      s.quote = a.quote
      s.bio = a.bio
      s.education = a.education
      s.work = a.work
      s.blogs = a.blogs
      s.github_cred = a.github_cred
      s.treehouse_cred = a.treehouse_cred
      s.codeschool_cred = a.codeschool_cred
      s.coderwall_cred = a.coderwall_cred
      s.favorite_website = a.favorite_website
      s.favorite_podcast = a.favorite_podcast
      s.flatiron_projects = a.flatiron_projects
      s.coding_profiles = a.coding_profiles
      s.personal_projects = a.personal_projects
      s.favorite_cities = a.favorite_cities
      s.blurb = 
      s.tagline 
      s.face_link
      s.bg_link 

      @students << s
  end


  def call

    index_scrape = IndexScraper.new(URL)
    @array.each do |a_url|
      page_scrape(a_url)    
    end

    @students #return of call
  end
end

