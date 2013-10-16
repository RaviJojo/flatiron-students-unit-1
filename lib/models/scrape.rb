require 'nokogiri'
require 'open-uri'
require 'pry'
require 'awesome_print'
PATH = "http://students.flatironschool.com/students/vinneycavallo.html"
# take these out when env is set up.

class StudentSiteScraper
  attr_accessor :doc
  # a single student page

  def initialize(url)
    @url = url
  end

  def call
    @doc = Nokogiri::HTML(open(@url))
  end

  def name
    @doc.css(".ib_main_header").children.text
  end

  def twitter
    @doc.css(".social-icons a")[0].attr('href').value
  end

  def linkedin
    @doc.css(".social-icons a")[1].attr('href').value
  end

  def github
    @doc.css(".social-icons a")[2].attr('href').value
  end

  def radar
    @doc.css(".social-icons a")[3].attr('href').value
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

  # John's code going here.



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


class StudentIndexScraper

  # this will scrape the index and get back urls
  # should probably also get the excerpts and stuff.

end



test = StudentSiteScraper.new(PATH)
test.call

binding.pry