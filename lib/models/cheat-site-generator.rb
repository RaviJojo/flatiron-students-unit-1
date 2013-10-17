class CheatSiteGenerator

  attr_accessor :students

  def initialize(student_array)
    @students = student_array
  end

  def call
    cheated_student_page = ERB.new(File.open('lib/views/cheat-show.erb').read)

    i = 0
    self.students.each do |student|
      File.open("_site/cheating/students/#{student.url}", "w+") do |f|
        f << cheated_student_page.result(binding)
      end
      i += 1
    end
  end

end

