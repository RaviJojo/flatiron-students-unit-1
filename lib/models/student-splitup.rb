=begin
    :twitter => "TEXT",
    :linkedin => "TEXT",
    :github => "TEXT",
    :website => "TEXT",
    :blog => "TEXT",
=end
class Student < StudentDB

  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :name => "TEXT"
  }
  
  def self.attributes_hash
    ATTRIBUTES
  end

  def self.attributes
    ATTRIBUTES.keys
  end

  def self.attributes_for_db
    ATTRIBUTES.keys.reject{|k| k == :id}
  end

  attr_accessor *attributes_for_db

  attr_reader :id
 
  def saved?

  end
end