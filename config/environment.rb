require 'nokogiri'
require 'open-uri'
require 'sqlite3'
require 'erb'
require 'pry'

URL = "http://students.flatironschool.com"
require_relative '../lib/models/student'
require_relative '../lib/models/scrape'
require_relative '../lib/models/clistudent'
require_relative '../lib/models/site-generator'