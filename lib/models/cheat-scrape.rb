class CheatScrape

  def initialize(url)
    @url = url
  end

  def give_raw_html
    doc = Nokogiri::HTML(open(@url))
    doc.to_html
  end  

end

test= CheatScrape.new("http://students.flatironschool.com/students/vinneycavallo.html")
binding.pry