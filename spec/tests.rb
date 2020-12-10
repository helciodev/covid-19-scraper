require_relative '../lib/scraper_logic'
require_relative '../bin/main'
require 'rspec'
require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-spinner'
require 'tty-link'


describe User_interface do
  let (:user_interface) {User_interface.new}
  let (:user_interface_1) {User_interface.new}

  describe '<< User_interface class >>'.magenta do
    it 'checks if user_interface.print_general_table equals user_interface_1.print_general_table' do
    expect(user_interface.print_general_table).to equal(user_interface_1.print_general_table)
    end
    it 'checks if user_interface.print_active_cases table equals user_interface_1.print_active_cases table' do
    expect(user_interface.print_active_cases).to equal( user_interface_1.print_active_cases)
    end
    it 'checks if user_interface.print_closed_cases table equals user_interface_1.print_closed_cases table' do
    expect(user_interface.print_closed_cases).to equal( user_interface_1.print_closed_cases)
    end
    it 'checks if user_interface.welcome_message equals user_interface_1.welcome_message' do
    expect(user_interface.welcome_message).to equal( user_interface_1.welcome_message)
    end
    it 'checks if user_interface.start_scraper equals user_interface_1.start_scraper' do
    expect(user_interface.start_scraper).to equal( user_interface_1.start_scraper)
    end
  end
end


describe Scraper do
  let(:scraper) {Scraper.new}
  let(:scraper_1) {Scraper.new}
  countries = [
    {
      :name=>"USA", 
      :total_cases=>"15,824,444", 
      :new_cases=>"+3,081", 
      :total_deaths=>"296,777 ", 
      :new_deaths=>"+62", 
      :total_recovered=>"9,233,622", 
      :new_recovered=>"+6,206", 
      :active_cases=>"6,294,045", 
      :serious_critical=>"27,329", 
      :total_cases_per_1_milion=>"47,684", 
      :deaths_per_1_milion=>"894", 
      :total_tests=>"213,118,147", 
      :tests_per_1_milion=>"642,193", 
      :population=>"331,859,797 ", 
      :continent=>"North America"
    },
    {
      :name=>"China", 
      :total_cases=>"86,673", 
      :new_cases=>"+12", 
      :total_deaths=>"4,634 ", 
      :new_deaths=>"", 
      :total_recovered=>"81,754", 
      :new_recovered=>"+11", 
      :active_cases=>"285", 
      :serious_critical=>"5", 
      :total_cases_per_1_milion=>"60", 
      :deaths_per_1_milion=>"3", 
      :total_tests=>"160,000,000", 
      :tests_per_1_milion=>"111,163", 
      :population=>"1,439,323,776 ", 
      :continent=>"Asia"
    }
  ]
  name = 'USA'

  describe '<< Scraper class >>'.magenta do
    it 'checks if scraper.print_country equals scraper_1.print_country' do
      expect(scraper.print_country(countries[0])).to equal(scraper_1.print_country(countries[0]))
      end
    it 'checks if scraper.print_all equals scraper_1.print_all' do
      expect(scraper.print_all(countries)).to equal(scraper_1.print_all(countries))
      end
    it 'checks if scraper.filter_country equals scraper_1.filter_country' do
      expect(scraper.filter_country(countries, name)).to equal(scraper_1.filter_country(countries, name))
      end
    it 'checks if scraper.ask_user equals scraper_1.ask_user' do
      expect(scraper.ask_user(countries)).to equal(scraper_1.ask_user(countries))
      end
  end
end

