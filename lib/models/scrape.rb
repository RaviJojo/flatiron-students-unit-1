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

  def biography
    begin
      @doc.css(".services-title")[0].parent.to_html
    rescue
      @@apology
    end
  end

  def education
    begin
      @doc.css(".services-title")[1].parent.to_html
    rescue
      @@apology
    end
  end
    #=> returns array of school names

  def work
    begin
      @doc.css(".services-title")[2].parent.to_html
    rescue
      @@apology
    end
  end

  def blogs
    begin
      @doc.css(".services-title")[4].parent.to_html
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

  def favorites
    begin
      @doc.css(".services-title")[7].parent.to_html
    rescue
      @@apology
    end
  end

  def flatiron_projects
    # combining with Work
    begin
      @doc.css(".services-title")[8].parent.to_html
    rescue
      @@apology
    end
  end

  def coding_profiles
    begin
      @doc.css(".services-title")[3].parent.to_html
    rescue
      @@apology
    end
  end
    #=> returns array of site links

  def personal_projects
    begin
      @doc.css(".services-title")[5].parent.to_html
    rescue
      @@apology
    end
  end

  def favorite_cities
    begin
      @doc.css(".services-title")[6].parent.to_html
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
      a = ItemScraper.new(a_url)
      data[:pic_names] = { face: a.doc.css('img.student_pic').attr('src').text.split("/").last, bg: a.doc.css('style').text.split("background: url(").last.split(")").first.split("/").last } 
      data[:name] = a.name
      data[:twitter] = a.twitter
      data[:linkedin] = a.linkedin
      data[:github] = a.github
      data[:radar] = a.radar
      data[:quote] = a.quote
      data[:biography_html] = a.biography
      data[:education_html] = a.education
      data[:work_html] = a.work
      data[:blogs_html] = a.blogs
      data[:github_cred] = a.github_cred
      data[:treehouse_cred] = a.treehouse_cred
      data[:codeschool_cred] = a.codeschool_cred
      data[:coderwall_cred] = a.coderwall_cred
      data[:favorites_html] = a.favorites
      data[:coding_profiles_html] = a.coding_profiles
      data[:personal_projects_html] = a.personal_projects
      data[:flatiron_projects_html] = a.flatiron_projects
      data[:favorite_cities_html] = a.favorite_cities
      pic_transform(a, data)

      @student_data_array << data
    end

    @student_data_array #return of call
  end
end

