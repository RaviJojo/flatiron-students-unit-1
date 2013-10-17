class CheatSiteGenerator

  attr_accessor :students

  def initialize(student_array)
    @students = student_array
    binding.pry
  end

  def call
    #index = ERB.new(File.open('lib/views/index.erb').read)
    cheated_student_page = ERB.new(File.open('lib/views/cheat-show.erb').read)
    #File.open('_site/index.html', 'w+') do |f|
    #  f << index.result(binding)
    #end

    i = 0
    self.students.each do |student|
      File.open("_site/cheating/students/#{i}.html", "w+") do |f|
        f << cheated_student_page.result(binding)
      end
      i += 1
    end
  end

end

