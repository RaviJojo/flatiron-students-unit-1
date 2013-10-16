class SiteGenerator

  attr_accessor :pages, :artists, :songs, :genres, :all_cat

  def initialize(artist_array, genre_array, song_array)
    @artists = artist_array
    @genres = genre_array
    @songs = song_array
    @pages = ["index", "artists", "genres", "artist", "genre"]
  end

  def call
    index = ERB.new(File.open('lib/views/index.erb').read)
    artists_page = ERB.new(File.open('lib/views/artists.erb').read)
    genres_page = ERB.new(File.open('lib/views/genres.erb').read)
    artist_page = ERB.new(File.open('lib/views/artist.erb').read)
    genre_page = ERB.new(File.open('lib/views/genre.erb').read)
    song_page = ERB.new(File.open('lib/views/song.erb').read)

    File.open('_site/index.html', 'w+') do |f|
      f << index.result(binding)
    end

    File.open('_site/genres.html', 'w+') do |f|
      f << genres_page.result(binding)
    end

    File.open('_site/artists.html', 'w+') do |f|
      f << artists_page.result(binding)
    end

    self.artists.each do |artist_object|
      File.open("_site/artists/#{artist_object.url}", "w+") do |f|
        f << artist_page.result(binding)
      end
    end

    self.genres.each do |genre_object|
      File.open("_site/genres/#{genre_object.url}", "w+") do |f|
        f << genre_page.result(binding)
      end
    end

    self.songs.each do |song_object|
      File.open("_site/songs/#{song_object.url}", "w+") do |f|
        f << song_page.result(binding)
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

