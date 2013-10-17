require_relative '../cheat-environment'

cheat_scrape = CheatScrape.new
student_hashes = cheat_scrape.call
students = student_hashes.collect do |student_hash|
  s = CheatStudent.new
  s.html = student_hash[:html]
  s.name = student_hash[:name]
  s
end

gen = CheatSiteGenerator.new(students)
gen.call
