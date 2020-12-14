require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-link'
require 'byebug'
require 'tty-spinner'
require_relative '../bin/user_interface'

scraper = UserInterface.new
scraper.start_scraper
