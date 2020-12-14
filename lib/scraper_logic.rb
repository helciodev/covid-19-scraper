require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-link'
require_relative '../bin/print_country'

class Scraper
  def initialize
    @print_c = PrintCountry.new
  end

  def print_all(countries_stats)
    countries_stats.each do |country|
    @print_c.print_country(country)
    end
  end

  def filter_country(countries, name)
    country = countries.select { |nation| nation[:name].upcase == name.upcase }
    country[0]
  end
end
