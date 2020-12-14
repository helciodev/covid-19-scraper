require_relative '../bin/user_interface'
require_relative '../lib/scraper_logic'

require 'rspec'
require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-link'

describe UserInterface do
  let(:user_interface) { UserInterface.new }
  let(:user_interface_one) { UserInterface.new }

  describe '<< UserInterface class >>'.magenta do
    it 'checks if user_interface.print_general_table equals user_interface_one.print_general_table' do
      expect(user_interface.print_general_table).to equal(user_interface_one.print_general_table)
    end
    it 'checks if user_interface.print_active_cases table equals user_interface_one.print_active_cases table' do
      expect(user_interface.print_active_cases).to equal(user_interface_one.print_active_cases)
    end
    it 'checks if user_interface.print_closed_cases table equals user_interface_one.print_closed_cases table' do
      expect(user_interface.print_closed_cases).to equal(user_interface_one.print_closed_cases)
    end
    it 'checks if user_interface.welcome_message equals user_interface_one.welcome_message' do
      expect(user_interface.welcome_message).to equal(user_interface_one.welcome_message)
    end
    it 'checks if user_interface.start_scraper equals user_interface_one.start_scraper' do
      expect(user_interface.start_scraper).to equal(user_interface_one.start_scraper)
    end
  end
end

describe Scraper do
  let(:scraper) { Scraper.new }
  let(:scraper_one) { Scraper.new }
  countries = [
    {
      name: 'USA',
      total_cases: '15,824,444',
      new_cases: '+3,081',
      total_deaths: '296,777 ',
      new_deaths: '+62',
      total_recovered: '9,233,622',
      new_recovered: '+6,206',
      active_cases: '6,294,045',
      serious_critical: '27,329',
      total_cases_per_1_milion: '47,684',
      deaths_per_1_milion: '894',
      total_tests: '213,118,147',
      tests_per_1_milion: '642,193',
      population: '331,859,797 ',
      continent: 'North America'
    },
    {
      name: 'China',
      total_cases: '86,673',
      new_cases: '+12',
      total_deaths: '4,634 ',
      new_deaths: '',
      total_recovered: '81,754',
      new_recovered: '+11',
      active_cases: '285',
      serious_critical: '5',
      total_cases_per_1_milion: '60',
      deaths_per_1_milion: '3',
      total_tests: '160,000,000',
      tests_per_1_milion: '111,163',
      population: '1,439,323,776 ',
      continent: 'Asia'
    }
  ]
  name = 'USA'

  describe '<< Scraper class >>'.magenta do
    it 'checks if scraper.print_all equals scraper_one.print_all' do
      expect(scraper.print_all(countries)).to equal(scraper_one.print_all(countries))
    end
    it 'checks if scraper.filter_country equals scraper_one.filter_country' do
      expect(scraper.filter_country(countries, name)).to equal(scraper_one.filter_country(countries, name))
    end
  end
end
