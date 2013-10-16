#student_scrape = StudentIndexScraper.new(URL)
#student_hashes = student_scrape.call

=begin
# sends output of scrape to a Ruby file
File.open("./studs.rb", 'a') do |file|
    file.write("def test")
    file.write("\n")
    file.write(student_hashes)
    file.write("\n")
    file.write("end")
end
=end

require_relative '../environment'

scrape = Scrape.new
student_hashes = scrape.call

students = student_hashes.collect do |student_hash|
  s = Student.new
  s.name = student_hash[:name]
  s.twitter = student_hash[:twitter]
  s.linkedin = student_hash[:linkedin]
  s.github = student_hash[:github]
  s.blog = student_hash[:blogs]
  s.education = student_hash[:education]
  s.bio = student_hash[:biography]
  s.save
end

cli = CLIStudent.new(students)
cli.call