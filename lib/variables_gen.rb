class VariableGenerator
  def active_cases_generator(doc)
    {
      currently_infected_patients: doc.css('.number-table-main')[0].text,
      in_mild_condition: doc.css('span.number-table')[0].text,
      mild_percentage: "#{doc.css('div.panel.panel-default strong')[0].text}%",
      serious_or_critical: doc.css('span.number-table')[1].text,
      serious_or_critical_percent: "#{doc.css('div.panel.panel-default strong')[1].text}%"
    }
  end

  def closed_cases_generator(doc)
    {
      cases_wich_had_an_outcome: doc.css('.number-table-main')[1].text,
      recovered_discharged: doc.css('span.number-table')[2].text,
      reco_dis_percentage: "#{doc.css('div.panel.panel-default strong')[2].text}%",
      deaths: doc.css('span.number-table')[3].text.gsub(/\n/, ''),
      death_percent: "#{doc.css('div.panel.panel-default strong')[3].text}%"
    }
  end

  def countries_stts(countries_and_t, countries)
    countries_and_t.each do |country_and_t|
      country = { name: country_and_t.css('td')[1].text,
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
                  continent: country_and_t.css('td')[15].text }
      countries.push(country)
    end
    countries
  end
end
