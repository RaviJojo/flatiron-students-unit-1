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
students = scrape.call


cli = CLIStudent.new(students)
cli.call