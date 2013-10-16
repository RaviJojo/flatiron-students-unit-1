require_relative '../environment.rb'

array = LibraryParser.new(DATA_PATH)
array.call


artists = Artist.all
genres = Genre.all
songs = Song.all


gen = SiteGenerator.new(artists, genres, songs)
gen.call