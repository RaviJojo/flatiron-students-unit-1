require_relative '../environment'

scrape = Scrape.new
students = scrape.call

gen = SiteGenerator.new(students)
gen.call