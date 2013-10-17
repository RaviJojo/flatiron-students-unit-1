class ItemScraper
  attr_accessor :doc
  # a single student page

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
      "rescued!"
    end
  end

  def twitter
    begin
    @doc.css(".social-icons a")[0].attr('href')
    rescue
      "rescued!"
    end
  end

  def linkedin
    begin
    @doc.css(".social-icons a")[1].attr('href')
    rescue
      "rescued!"
    end
  end

  def github
    begin
    @doc.css(".social-icons a")[2].attr('href')
    rescue
      "rescued!"
    end
  end

  def radar
    begin
    @doc.css(".social-icons a")[3].attr('href')
    rescue
      "rescued!"
    end
  end
  # this is the "rss"/facebook link.

  def quote
    begin
    @doc.css(".textwidget").text.strip
    rescue
      "rescued!"
    end
  end

  def bio
    begin
    @doc.css("#ok-text-column-2 .services p").first.content.gsub("\n","")
    rescue
      "rescued!"
    end
  end

  def education
    begin
    all_education = @doc.css("#ok-text-column-3 .services ul li").collect do |
        school|
      school.content
    end
  rescue
    "rescued!"
  end
  end
    #=> returns array of school names

  def work
    begin
    @doc.css("#ok-text-column-4 .services p").children[0].text.gsub("\n","")
    rescue
      "rescued!"
    end
  end

  def blogs
    begin
    all_blogs = @doc.css("#ok-text-column-3 .services p")[0].css("a").collect do |
        blog|
      blog.attr('href')
    end
  rescue
    "rescued!"
  end
  end
    #=> returns an array of blog links

  def github_cred
    begin
    @doc.css(".coder-cred")[0].children.children[1].attr('href')
    rescue
      "rescued!"
    end
  end

  def treehouse_cred
    begin
    @doc.css(".coder-cred")[0].children.children[4].attr('href')
    rescue
      "rescued!"
    end
  end

  def codeschool_cred
    begin
    @doc.css(".coder-cred")[0].children.children[7].attr('href')
    rescue
      "rescued!"
    end
  end

  def coderwall_cred
    begin
    @doc.css(".coder-cred")[0].children.children[10].attr('href')
    rescue
      "rescued!"
    end
  end

  def favorite_website
    begin
    @doc.css("#ok-text-column-3 .services p").children[10].attr('href')
    rescue
      "rescued!"
    end
  end

  def favorite_comic
    begin
    @doc.css("#ok-text-column-3 .services p").children[13].attr('href')
    rescue
      "rescued!"
    end
  end

  def favorite_podcast
    begin
    @doc.css("#ok-text-column-3 .services p").children[16].attr('href')
    rescue
      "rescued!"
    end
  end

  def flatiron_projects
    begin
    @doc.css("#ok-text-column-4 .services p").children[1].text
    rescue
      "rescued!"
    end
  end

  def coding_profiles
    begin
    all_links = @doc.css('#ok-text-column-2 .services p')[1].css('a').collect do |
        link|
      link.attr('href')
    end
  rescue
    "rescued!"
  end
  end
    #=> returns array of site links

  def personal_projects
    begin
    @doc.css('#ok-text-column-4 .services p')[3].content
    rescue
      "rescued!"
    end
  end

  def favorite_cities
    begin
    all_cities = @doc.css('#ok-text-column-2 .services p')[2].css("a").collect do |city|
      city.text
    end
  rescue
    "rescued!"
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

=begin  - Raymond's index page scrape:
    doc = Nokogiri::HTML(open(self.url))
    frontpage = doc.css(".home-blog-post")

    photo_urls = frontpage.map do |student|
      student.css(".prof-image").attr("src").to_s
    end

    taglines = frontpage.map do |student|
      student.css(".home-blog-post-meta").text
    end

    blurbs = frontpage.map do |student|
      student.css(".excerpt p").text.squeeze(' ')
    end
=end

end

class Scrape
  attr_accessor :students

  def initialize
    url_list = IndexScraper.new(URL)
    @array = url_list.get_student_urls 
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


  def call
  
    @array.each do |a_url|
      data = {}
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

      @students << s
    end

    @students #return of call
  end
end

class CreateHash

  # iterate over array of student URLS
  # create a new StudentSiteScraper instance with each URL
  # Scrape! the student.

  #student_hashes = array of hashes (one per student)

end