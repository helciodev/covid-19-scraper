
class PrintCountry
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
end
