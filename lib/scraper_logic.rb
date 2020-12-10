require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-spinner'
require 'tty-link'
require 'byebug'

require_relative '../bin/main'

class Scraper

    def print_all
        $countries_stats.each do |country|
          print_country(country)
        end
        
    def filter_country(countries, name)
        name = name
        country = countries.select { |nation| nation[:name].upcase == name.upcase }
       country[0]
      end
end