
class CheatItemScraper
  attr_accessor :doc
  
  def initialize(url)
    begin
      @doc = Nokogiri::HTML(open(url))
    rescue
      "rescued!"
    end
  end


  def raw_html
    @doc.to_html
  end  
  
  def name
    begin
      @doc.css(".ib_main_header").children.text
    rescue
    end
  end

end


class CheatIndexScraper
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

end

class CheatScrape
  attr_accessor :student_data_array

  def initialize
    url_list = CheatIndexScraper.new(URL)
    @array = url_list.get_student_urls 
    @student_data_array = []
  end

   def call
  
    @array.each do |a_url|
      data = {}
      a = CheatItemScraper.new(a_url)
      data[:html] = a.raw_html
      data[:name] = a.name

      @student_data_array << data
    end

    @student_data_array #return of call
  end
end



