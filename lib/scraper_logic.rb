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
    end

    def filter_country(countries, name)
        name = name
        country = countries.select { |nation| nation[:name].upcase == name.upcase }
       country[0]
    end

  def ask_user
    
    prompt = TTY::Prompt.new
    puts ""
    user_input = prompt.select("Choose 'All' or a specific country to know stats     about covid-19?", 'All', $countries_stats.each { |country_name| country_name    [:name] }).capitalize
            
    case user_input
      when 'All'
      print_all
      else
      print_country(filter_country($countries_stats, user_input))
    end
    font = TTY::Font.new(:doom)
    puts font.write("thanks for using").light_blue
  end

end