require_relative '../config/environment'

scrape = Scrape.new
students = scrape.call


cli = CLIStudent.new(students)
cli.call