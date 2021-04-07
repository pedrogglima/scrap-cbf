# ScrapCbf

With ScrapCbf you will be able to scrap data from the [CBF official page](https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a) for Serie A and B. Some of these data are: matches, matches per round, ranking table, teams and the team's flag image. You will also be able to choose, by year, the Championship you want to scrap. The CBF page has records starting from the Championship 2012, and they keep updating, daily, the current Championship with the results from the matches. On below we have a sample from the scraped data:

    "championship": {
      "year": 2021,
      "serie": "serie_a"
    },
    "matches": [
      {
        "championship": 2021,
        "serie": "serie_a",
        "round": 1,
        "team": "Coritiba",
        "opponent": "Palmeiras",
        "id_match": "348",
        "team_score": 1,
        "opponent_score": 0,
        "updates": "2 alterações",
        "date": "17/02/2021 19:30",
        "start_at": "19:30",
        "place": "Couto Pereira - Curitiba - PR"
      },
      ... # more matches
    ],
    "rankings": [
      {
        "championship": 2021,
        "serie": "serie_a",
        "position": "1",
        "team": "America",
        "points": "0",
        "played": "0",
        "won": "0",
        "drawn": "0",
        "lost": "0",
        "goals_for": "0",
        "goals_against": "0",
        "goal_difference": "0",
        "yellow_card": "0",
        "red_card": "0",
        "advantages": "0",
        "form": "",
        "next_opponent": ""
      },
      ... # more ranks
    ],
    "rounds": [
      {
        "championship": 2021,
        "serie": "serie_a",
        "number": 1,
        "matches": [
          {
            "championship": 2021,
            "serie": "serie_a",
            "round": 1,
            "team": "Coritiba",
            "opponent": "Palmeiras",
            "id_match": "348",
            "team_score": 1,
            "opponent_score": 0,
            "updates": "2 alterações",
            "date": "17/02/2021 19:30",
            "start_at": "19:30",
            "place": "Couto Pereira - Curitiba - PR"
          },
          ... # matches per round
        ],s
      },
      ... # more rounds
    },
    "teams": [
      {
        "name": "America",
        "state": "MG",
        "avatar_url": "https://conteudo.cbf.com.br/cdn/imagens/escudos/00001mg.jpg?v=2021040711"
      },
      ... # more teams
    ]

Note: if you need to save the scrap data on your app, you can check the gem [ScrapCbfRecord](https://github.com/pedrogglima/scrap-cbf-record).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scrap_cbf'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scrap_cbf

## Usage

To scrap data and get the result you can:

    cbf = ScrapCbf.new(year: 2020, serie: :serie_a)

    # returns all entities in Hash format
    cbf.to_h
    # returns all entities in JSON format (equivalent to call cbf.to_h.to_json)
    cbf.to_json
    # print on console all entities in pretty format
    cbf.print

    # if you want data by entity you can (works also with #to_json and #print)
    cbf.championship.to_h
    cbf.matches.to_h
    cbf.rankings.to_h
    cbf.rounds.to_h
    cbf.teams.to_h

If you need to work repeatedly with the data and don't want to hit the CBF page every time:

    # This load a saved sample from the CBF page.
    cbf = ScrapCbf.new(year: 2020, serie: :serie_a, load_from_sample: true)

If you want to check the year or serie you can pass as argument

    # returns the range of years possible to scrap
    ScrapCbf::Document::CHAMPIONSHIP_YEARS

    # returns the possible series
    ScrapCbf::Document::SERIES

    # returns the url for the CBF page
    ScrapCbf::Document::URL

Note: because this gem depends on a third party software, it's out of our control to foresee changes on the CBF official page. You may benefit from background jobs while using this gem. A rake task to inspect the scraped data may help, too:

    namespace :scrap_cbf do
      task :print do
        cbf = ScrapCbf.new({ year: 2021 })

        p '-------------------- CBF DATA -----------------------'
        cbf.print
        p '-----------------------------------------------------'
      end
    end

## Development

Right now, this gem doesn't cover too much tests, at least the code related to scraping html. That is because we rely on a third party software, which means we can't predict changes. Another reason is the fact that we are dealing with views code, which means they usually tend to change if more frequency. For last, it doesn't seems to have standart ways of testing this kind of application. To help understanding the library I wrote a Readme inside each module folder.

To run the tests

    rake spec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pedrogglima/scrap_cbf. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ScrapCbf project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pedrogglima/scrap_cbf/blob/master/CODE_OF_CONDUCT.md).
