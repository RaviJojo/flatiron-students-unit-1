require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'erb'
require 'pry'

URL = "http://students.flatironschool.com"
require_relative './lib/models/cheat-student'
require_relative './lib/models/cheat-scrape'
require_relative './lib/models/cheat-site-generator'
