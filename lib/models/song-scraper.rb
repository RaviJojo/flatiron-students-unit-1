class SongScraper

  attr_accessor :query, :target_page, :lyrics

  SEARCH_URL = "http://www.songlyrics.com/index.php?section=search&searchW="

  EXPLICIT_CONTENT = ["nigga", "pussy", "ass", "shit", "fuck", "vagina", "bitch", "dick", "fuckin'", "fuckin", "fucked"]

  WARNING = "Warning: Explicit Content!"

  def initialize(query)
    @query = query
    @target_page = ''
    @lyrics = ''

    set_all
  end

  def set_all
    parse_search
    scrape_target
  end

  def parse_search
    doc = Nokogiri::HTML(open(SEARCH_URL+"#{self.query}"))
    self.target_page = doc.css('div.serpresult').first.css('a').attr('href').text
    puts "grabbed the link from the query #{self.query}"
  end

  def scrape_target # returns a string
    target = Nokogiri::HTML(open(self.target_page))
    self.lyrics = target.css('p#songLyricsDiv').text
    puts "grabbed the lyrics for #{self.query}!"
  end

  def htmlify_lyrics
    self.lyrics.gsub("\n","<br>")
  end


end






