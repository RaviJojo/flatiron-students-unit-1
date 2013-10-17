# CLIStudent.new(students). students are a bunch of student instances.
# The CLIStudent should have a browse (which lists all students), a help, a show
# (by ID or name), which shows all data of a student, and exit.

class CLIStudent
  attr_reader :students

  APPROVED_COMMANDS = [:browse, :show, :help, :exit]

  def initialize(students)
    @students = students
    @on = true
  end

  def on?
    @on
  end

  def call
    puts "#{self.students.size} students loaded."
    choice = ''
    while on?
      while !APPROVED_COMMANDS.include?(choice)
        puts "Type command (browse, show, help, or exit):"
        choice = gets.chomp.strip.downcase.to_sym
      end

    # "send" invokes method called. http://www.ruby-doc.org/core-2.0.0/Object.html#method-i-send
      self.send(choice)
      choice = ''
    end
  end

  def browse
    Student.all.each do |s|
      puts "#{s.id} #{s.name}"
    end
  end

  def help
    puts "Instructions. Type:"
    puts "-------------------------"
    puts "'help' to see this list of commands"
    puts "'browse' to list the students you can view"
    puts "'show student_name or id' to see a student's info"
    puts "'exit' to exit."
    puts "-------------------------"
    puts 
  end

  def show
    print "Enter student id or ANY PART of student name: "
    search = gets.chomp.strip.downcase
    if search.to_i.to_s == search     # if user enters ID number
      display(Student.find(search.to_i))
    else
      display(Student.find_by_name(search))
    end
  end

  def makeArray(student)
    student.is_a?(Array) ? student : [student]
  end

  def display(student)
    puts "Student(s)"
    puts "---------------------"
    sarray = makeArray(student)
    if sarray.size == 0
      puts "No students found."
    else 
      sarray.each do |s|
        puts "Name: #{s.name}"
        puts "Twitter: #{s.twitter}"
        puts "LinkedIn: #{s.linkedin}"
        puts "GitHub: #{s.github}"
        puts "Quote: #{s.quote}"
        puts "Bio: #{s.bio}"
        puts "Education: #{s.education}"
        puts "Work: #{s.work}"
        puts "Blogs: #{s.blogs}"
        puts "Radar: #{s.radar}"
        puts "Favorite website: #{s.favorite_website}"
        puts "Favorite podcast: #{s.favorite_podcast}"
        puts "Flatiron projects: #{s.flatiron_projects}"
        puts "Personal_projects: #{s.personal_projects}"
        puts "Favorite_cities: #{s.favorite_cities}"

      end
    end
  end

  def exit
    puts "Goodbye"
    @on = false
  end
end