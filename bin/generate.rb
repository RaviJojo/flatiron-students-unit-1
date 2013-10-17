require_relative '../environment'

scrape = Scrape.new
student_hashes = scrape.call
students = student_hashes.collect do |student_hash|
  s = Student.new
  s.name = student_hash[:name]
  s.twitter = student_hash[:twitter]
  s.linkedin = student_hash[:linkedin]
  s.github = student_hash[:github]
  s.blogs = student_hash[:blogs]
  s.education = student_hash[:education]
  s.bio = student_hash[:biography]
  s.radar = student_hash[:radar]
  s.quote = student_hash[:quote]
  s.work = student_hash[:work]
  s.github_cred = student_hash[:github_cred]
  s.treehouse_cred = student_hash[:treehouse_cred]
  s.codeschool_cred = student_hash[:codeschool_cred]
  s.coderwall_cred = student_hash[:coderwall_cred]
  s.favorite_website = student_hash[:favorite_website] 
  s.favorite_podcast = student_hash[:favorite_podcast]
  s.flatiron_projects = student_hash[:flatiron_projects]
  s.coding_profiles = student_hash[:coding_profiles] 
  s.personal_projects = student_hash[:personal_projects] 
  s.favorite_cities = student_hash[:favorite_cities] 
  s.favorite_comic = student_hash[:favorite_comic] 
  s.save
  s
end

# gen = SiteGenerator.new(students)
# gen.call