class ItemScraper
  attr_accessor :doc
  # a single student page

  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
  end

  def name
    @doc.css(".ib_main_header").children.text
  end

  def twitter
    @doc.css(".social-icons a")[0].attr('href')
  end

  def linkedin
    @doc.css(".social-icons a")[1].attr('href')
  end

  def github
    @doc.css(".social-icons a")[2].attr('href')
  end

  def radar
    @doc.css(".social-icons a")[3].attr('href')
  end
  # this is the "rss"/facebook link.

  def quote
    @doc.css(".textwidget").text.strip
  end

  def biography
    @doc.css("#ok-text-column-2 .services p").first.content.gsub("\n","")
  end

  def education
    all_education = @doc.css("#ok-text-column-3 .services ul li").collect do |school|
      school.content
    end
  end
    #=> returns array of school names

  def work
    @doc.css("#ok-text-column-4 .services p").children[0].text.gsub("\n","")
  end

  def blogs
    all_blogs = @doc.css("#ok-text-column-3 .services p")[0].css("a").collect do |blog|
      blog.attr('href')
    end
  end
    #=> returns an array of blog links

  def github_cred
    @doc.css(".coder-cred")[0].children.children[1].attr('href')
  end

  def treehouse_cred
    @doc.css(".coder-cred")[0].children.children[4].attr('href')
  end

  def codeschool_cred
    @doc.css(".coder-cred")[0].children.children[7].attr('href')
  end

  def coderwall_cred
    @doc.css(".coder-cred")[0].children.children[10].attr('href')
  end

  def favorite_website
    @doc.css("#ok-text-column-3 .services p").children[10].attr('href')
  end

  def favorite_comic
    @doc.css("#ok-text-column-3 .services p").children[13].attr('href')
  end

  def favorite_podcast
    @doc.css("#ok-text-column-3 .services p").children[16].attr('href')
  end

  def flatiron_projects
    @doc.css("#ok-text-column-4 .services p").children[1].text
  end

  def coding_profiles
    all_links = @doc.css('#ok-text-column-2 .services p')[1].css('a').collect do |link|
      link.attr('href')
    end
  end
    #=> returns array of site links

  def personal_projects
    @doc.css('#ok-text-column-4 .services p')[3].content
  end

  def favorite_cities
    all_cities = @doc.css('#ok-text-column-2 .services p')[2].css("a").collect do |city|
      city.text
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
  attr_accessor :student_data_array

  def initialize
    url_list = IndexScraper.new(URL)
    @array = url_list.get_student_urls 
    @student_data_array = []
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
      begin
      a = ItemScraper.new(a_url)
      data[:pic_names] = { face: a.doc.css('img.student_pic').attr('src').text.split("/").last, bg: a.doc.css('style').text.split("background: url(").last.split(")").first.split("/").last } 
      data[:name] = a.name
      data[:twitter] = a.twitter
      data[:linkedin] = a.linkedin
      data[:github] = a.github
      data[:radar] = a.radar
      data[:quote] = a.quote
      data[:biography] = a.biography
      data[:education] = a.education
      data[:work] = a.work
      data[:blogs] = a.blogs
      data[:github_cred] = a.github_cred
      data[:treehouse_cred] = a.treehouse_cred
      data[:codeschool_cred] = a.codeschool_cred
      data[:coderwall_cred] = a.coderwall_cred
      data[:favorite_website] = a.favorite_website
      data[:favorite_podcast] = a.favorite_podcast
      data[:flatiron_projects] = a.flatiron_projects
      data[:coding_profiles] = a.coding_profiles
      data[:personal_projects] = a.personal_projects
      data[:favorite_cities] = a.favorite_cities
      data[:favorite_comic] = a.favorite_comic
      rescue
      end
      pic_transform(a, data)

      @student_data_array << data
    end

    @student_data_array #return of call
  end
end

class CreateHash

  # iterate over array of student URLS
  # create a new StudentSiteScraper instance with each URL
  # Scrape! the student.

  #student_hashes = array of hashes (one per student)

end