require 'nokogiri'
require 'open-uri'
# take these out when env is set up.

class StudentSiteScraper

  def initialize(url)
    @url = url
  end

  @student_page = Nokogiri::HTML(open(@url))

end


class StudentIndexScraper

  # this will scrape the index and get back urls
  # should probably also get the excerpts and stuff.

end