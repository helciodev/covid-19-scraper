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

