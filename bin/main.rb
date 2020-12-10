require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-spinner'
require 'tty-link'


require_relative '../lib/scraper_logic'

class User_interface
  attr_accessor :scraper_logic


  def initialize
    @spinner = TTY::Spinner.new
    self.scraper_logic = Scraper.new
    @url = 'https://www.worldometers.info/coronavirus/'
    @doc = Nokogiri::HTML(URI.open(@url))
    @countries_and_territories = @doc.css('tr').reject { |tr| tr['data-continent'] }[2..221]
    @countries_stats = []
    @general_info = @doc.css('#maincounter-wrap').map do |e|
    e.text
     .gsub(/\n/, '')
     .split(':')
    end

    @active_cases = {
    currently_infected_patients: @doc.css('.number-table-main')[0].text,
    in_mild_condition: @doc.css('span.number-table')[0].text,
    mild_percentage: @doc.css('div.panel.panel-default strong')[0].text + '%',
    serious_or_critical: @doc.css('span.number-table')[1].text,
    serious_or_critical_percent: @doc.css('div.panel.panel-default strong')[1].text + '%',
    }

    @closed_cases = {
    cases_wich_had_an_outcome: @doc.css('.number-table-main')[1].text,
    recovered_discharged: @doc.css('span.number-table')[2].text,
    reco_dis_percentage: @doc.css('div.panel.panel-default strong')[2].text + '%',
    deaths: @doc.css('span.number-table')[3].text.gsub(/\n/, ''),
    death_percent: @doc.css('div.panel.panel-default strong')[3].text + '%',
    }

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

  def print_general_table
    puts ""
    puts "General information about covid-19 worldwide:"
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
    puts ""
 end

#  print active cases
def print_active_cases
  p 'Active cases:'.upcase
  puts Terminal::Table.new(
    rows: [
      [@active_cases[:currently_infected_patients],@active_cases[:in_mild_condition] , @active_cases[:mild_percentage],@active_cases[:serious_or_critical],@active_cases[:serious_or_critical_percent] ] 
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
    box = TTY::Box.info("welcome to covid-19 scraper")
    print box
  end

  # print closed cases
  def print_closed_cases
    p 'Closed cases:'.upcase
    puts Terminal::Table.new(
      rows: [
        [@closed_cases[:cases_wich_had_an_outcome],@closed_cases[:recovered_discharged] , @closed_cases[:reco_dis_percentage],@closed_cases[:deaths],@closed_cases[:death_percent] ] 
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
    puts ""
  end

    # print general table method
   def start_scraper
    @spinner.auto_spin
    print TTY::Link.link_to("fetching data from", "https://www.worldometers.info/coronavirus/")
    @spinner.success
    welcome_message
    print_general_table
    print_active_cases
    print_closed_cases
    scraper_logic.ask_user(@countries_stats)
    
   end

end

scrape = User_interface.new

# scrape.print_active_cases
scrape.start_scraper
