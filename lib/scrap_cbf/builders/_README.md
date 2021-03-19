# Builders

Builders, in the context of this gem, are the classes responsible for scraping specific entity, usually, from the page. I'm saying usually here because the builder may scrap a collection of entities (e.g all matches from the Championship 2020), or a group of entities (e.g scrap matches per round for a certain Championship). Builders should save the entities scraped on a Models (see lib/models). Builder usually returns an Array of certain entity, e.g:

    @matches = MatchesBuilder.new(match_elements)

Because the logic for scraping data is so verbose and complex, we try to keep the Builder class as easy as possible to understand. One way to do this is encapsulating the auxilar methods on a different module (see lib/helpers). Another way is using a pattern for the most common cases. Here is an example:

```#ruby
class MatchesBuilder

  def initialize(matches_elements)
    @matches = []

    scrap_matches(matches_elements)
  end

  private

  def scrap_matches(matches_elements)
    matches_elements.children.each do |match_element|
      next unless match_element.element?

      @matches << scrap_match(match_element)
    end
  end

  def scrap_match(match_element)
    match = Match.new

    # e.g "Qua, 03/02/2021 16:00 - Jogo: 336"
    scrap_info(match, match_element)
    
    # e.g <img title="team-name">
    scrap_teams(match, match_element)

    match
  end

  def scrap_info(match, match_element)
    # some code
  end

  def scrap_teams(match, match_element)
    # some code
  end
end
```

On the example above, we try to keep only the methods that has a real meaning for the Matches Builder context. Example: scrap_info and scrap_teams methods tells us that 'info' and 'teams' are part of the Match entity. On the otherside, a auxiliar method for scrap_teams method with the name 'team_name_or_nil' wouldn't tell us much about what is the purpose of the Builder class. So this method would be better fit on the MatchesHelper module.

There are some cases that is not possible to achieve this pattern. One example is when scraping a table. Because we can't scrap all the data of a row at once (usually they are not well descriptive to do so), we need to full fill a table model fist. With the table model in hands we can create the real entities. This case happens with the Rankings entity.
