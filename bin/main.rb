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

class User_interface

  def initialize
    @url = 'https://www.worldometers.info/coronavirus/'
    @doc = Nokogiri::HTML(URI.open(@url))
    @spinner = TTY::Spinner.new
    @countries_and_territories = @doc.css('tr').reject { |tr| tr['data-continent'] }[2..221]
    @countries_stats = []

    @countries_and_territories.each  do |country_and_t|
        country = {
          name: country_and_t.css('td')[1].text, 
          total_cases: country_and_t.css('td')[2].text,
          new_cases: country_and_t.css('td')[3].text,
          total_deaths: country_and_t.css('td')[4].text,
          new_deaths: country_and_t.css('td')[5].text,
          total_recovered: country_and_t.css('td')[6].text,
          new_recovered: country_and_t.css('td')[7].text,
          active_cases: country_and_t.css('td')[8].text,
          serious_critical: country_and_t.css('td')[9].text,
          total_cases_per_1_milion: country_and_t.css('td')[10].text,
          deaths_per_1_milion: country_and_t.css('td')[11].text,
          total_tests: country_and_t.css('td')[12].text,
          tests_per_1_milion: country_and_t.css('td')[13].text,
          population: country_and_t.css('td')[14].text,
          continent: country_and_t.css('td')[15].text
          }
          @countries_stats.push(country)
    end
  end

end

user = User_interface.new
user.scraper