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
require_relative './lib/scraper_logic'
require_relative './variables_gen'

class UserInterface
  attr_accessor :scraper_logic, :cases

  def initialize
    @spinner = TTY::Spinner.new
    self.scraper_logic = Scraper.new
    self.cases = VariableGenerator.new
    @spinner.auto_spin
    print TTY::Link.link_to('fetching data from: ', 'https://www.worldometers.info/coronavirus/'.blue)
    @doc = Nokogiri::HTML(URI.open('https://www.worldometers.info/coronavirus/'))
    @spinner.success
    @countries_and_territories = @doc.css('tr').reject { |tr| tr['data-continent'] }[2..221]
    @countries_stats = []
    @general_info = @doc.css('#maincounter-wrap').map do |e|
      e.text
        .gsub(/\n/, '')
        .split(':')
    end
    @active_cases = cases.active_cases_generator(@doc)
    @closed_cases = cases.closed_cases_generator(@doc)
    @countries_stats = cases.countries_stts(@countries_and_territories, @countries_stats)
  end

  def print_general_table
    puts ''
    puts 'General information about covid-19 worldwide:'
    puts Terminal::Table.new(
      rows: [
        [@general_info[0][1], @general_info[1][1], @general_info[2][1]]
      ],
      headings: [
        @general_info[0][0].bold.blue,
        @general_info[1][0].bold.light_white,
        @general_info[2][0].bold.green
      ],
      style: {
        border_i: '+'
      }
    )
    puts ''
  end

  #  print active cases
  def print_active_cases
    p 'Active cases:'.upcase
    puts Terminal::Table.new(
      rows: [
        [@active_cases[:currently_infected_patients],
         @active_cases[:in_mild_condition],
         @active_cases[:mild_percentage],
         @active_cases[:serious_or_critical],
         @active_cases[:serious_or_critical_percent]]
      ],
      headings: [
        'Currently infected patients',
        'In mild conditions'.blue,
        'In mild conditions %'.blue,
        'Serious/critical'.red,
        'Serious/Critical %'.red
      ],
      style: {
        border_i: '+'
      }
    )
  end

  def welcome_message
    box = TTY::Box.info('welcome to covid-19 scraper')
    print box
  end

  # print closed cases
  def print_closed_cases
    p 'Closed cases:'.upcase
    puts Terminal::Table.new(
      rows: [
        [@closed_cases[:cases_wich_had_an_outcome],
         @closed_cases[:recovered_discharged],
         @closed_cases[:reco_dis_percentage],
         @closed_cases[:deaths],
         @closed_cases[:death_percent]]
      ],
      headings: [
        'Cases wich had an outcome',
        'Recovered Discharged'.green,
        'Recovered/discharged %'.green,
        'Deaths'.red,
        'Death %'.red
      ],
      style: {
        border_i: '+'
      }
    )
  end

  # print general table method
  def start_scraper
    puts ''
    welcome_message
    print_general_table
    print_active_cases
    print_closed_cases
    scraper_logic.ask_user(@countries_stats)
  end
end
