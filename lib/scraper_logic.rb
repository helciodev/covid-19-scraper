require 'nokogiri'
require 'colorize'
require 'open-uri'
require 'terminal-table'
require 'tty-font'
require 'tty-prompt'
require 'tty-box'
require 'tty-link'

class Scraper
  def print_second_table_c(country)
    puts Terminal::Table.new(
      rows: [
        [
          country[:total_recovered],
          country[:new_recovered],
          country[:active_cases],
          country[:serious_critical],
          country[:total_cases_per_1_milion]
        ]
      ],
      headings: [
        'Total reco'.bold.green,
        'New reco'.bold.green,
        'Active cases'.red,
        'Serious/critical'.red,
        'Total cases/1M'.bold.blue
      ],
      style: { border_i: '+' }
    )
  end

  def print_third_table_c(country)
    puts Terminal::Table.new(
      rows: [
        [
          country[:deaths_per_1_milion],
          country[:total_tests],
          country[:tests_per_1_milion],
          country[:population],
          country[:continent]
        ]
      ],
      headings: [
        'Total deaths/1M'.red,
        'Total tests'.bold.blue,
        'Total tests/1M'.bold.blue,
        'Population'.bold.green,
        'continent'.bold.green
      ],
      style: { border_i: '+' }
    )
  end

  def print_country(country)
    puts Terminal::Table.new(
      rows: [
        [
          country[:name],
          country[:total_cases],
          country[:new_cases],
          country[:total_deaths],
          country[:new_deaths]
        ]
      ], headings: [
        'Country'.bold.blue,
        'Total'.red,
        'New cases'.bold.blue,
        'Total deaths'.bold.red,
        'New deaths'.red
      ],
      style: { border_i: '+' }
    )
    print_second_table_c(country)
    print_third_table_c(country)
  end

  def print_all(countries_stats)
    countries_stats.each do |country|
      print_country(country)
    end
  end

  def filter_country(countries, name)
    country = countries.select { |nation| nation[:name].upcase == name.upcase }
    country[0]
  end

  def ask_user(countries_stats)
    prompt = TTY::Prompt.new
    puts ''
    user_input = prompt.select("Choose 'All' to print 220 indivdual
    contries stats about covid-19 or choose a specific
    country to know stats about covid-19?", 'All', countries_stats.each { |country_name| country_name[:name] })

    case user_input
    when 'All'
      print_all(countries_stats)
    else
      print_country(filter_country(countries_stats, user_input))
    end
    font = TTY::Font.new(:doom)
    git_repo = TTY::Link.link_to('if you liked it give a ⭐ t', 'https://github.com/helciodev/covid-19-scraper'.blue)

    puts font.write('thanks for using').light_blue
    puts git_repo
  end
end
