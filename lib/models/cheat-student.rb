class CheatStudent

  attr_accessor :html, :name, :url

  def url
    self.name.downcase.gsub(/\s|'/,'_') + '.html'
  end

end