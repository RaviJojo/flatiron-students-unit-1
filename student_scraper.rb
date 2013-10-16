# Raymond Gan -- StudentScraper - revised

require 'nokogiri'
require 'open-uri'

class StudentScraper
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def call
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

    slinks = doc.css('.big-comment a').map { |link| self.url + '/' + link['href'] }
    student_hashes = []

    slinks.size.times do |i|
      begin
        s = Nokogiri::HTML(open(slinks[i]))   # each i gives you different student
        student = {}

        # keep all these indexes (0) the same. Don't change 0. They are all for same student.
        student[:name] = s.css('h4')[0].text 
        student[:twitter] = s.css('.social-icons a')[0].attr('href')
        student[:linkedin] = s.css('.social-icons a')[1].attr('href')
        student[:github] = s.css('.social-icons a')[2].attr('href')
        student[:blog] = s.css('.services a')[4].attr('href')

        #s.css('.social-icons a').each do |j|
        #  socialinks << j.attr('href')   # all student's social media links
        #end

        student[:photo_urls] = photo_urls[i]
        student[:taglines] = taglines[i]
        student[:quote] = s.css('h3')[0].children.text.squeeze(' ')
        student[:blurbs] = blurbs[i]
        student[:bio] = s.css('.services p')[0].children.text.strip.squeeze(' ')
        student[:work] = s.css('.services p')[1].children.text.strip.squeeze(' ')
        student[:education] = s.css('.services ul')[0].children.text.squeeze(' ').split("\n ")
        student[:codeschool] = s.css('.services a')[0].attr('href')
        student[:treehouse] = s.css('.services a')[1].attr('href')
        student[:codecademy] = s.css('.services a')[2].attr('href')
        student[:coderwall] = s.css('.services a')[3].attr('href')
        student[:pprojects] = s.css('.services p')[4].text.squeeze(' ')
      rescue         # Catch if link doesn't work
      end
      student_hashes << student
    end
    student_hashes
  end
end

=begin
main_index_url = "http://students.flatironschool.com"
student_scrape = StudentScraper.new(main_index_url)
student_hashes = student_scrape.call

student_hashes.each do |sh|
  puts sh
end
=end