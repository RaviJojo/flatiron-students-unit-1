class SiteGenerator

  attr_accessor :students, :index_info

  def initialize(student_array)
    @students = student_array
    @index_info = index_info # hash
  end

  def call
    index = ERB.new(File.open('lib/views/index.erb').read)
    student_page = ERB.new(File.open('lib/views/show.erb').read)

    File.open('_site/index.html', 'w+') do |f|
     f << index.result(binding)
    end

    self.index_info

    self.students.each do |student|
      File.open("_site/students/#{student.url}", "w+") do |f|
        f << student_page.result(binding)
      end
    end
  end


  def create_erb_object(page)
      # ERB.new(File.open("lib/views/#{page}.erb").read)
  end


  def create_html_file(page)
      # File.open("_site/#{page}.html", "w+") do |f|
      #   f << page.result(binding)
      # end
  end

end

