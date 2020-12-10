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
    it 'prints general table method ' do
    expect(user_interface.print_general_table).to equal( print user_interface_1.print_general_table)
    end
  end
end

