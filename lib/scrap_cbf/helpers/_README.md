# Helpers

Helpers are responsable to encapsulate logic that belongs to Builders (see lib/builders). Because Helpers have logic that belongs to Builders, we should see no real difference between these methods been placed on the Builders or on the Helpers. The reason they are placed here, on the helpers, is to keep only meaningful named methods on the Builders. This is important because of the nature of the Builders (see lib/builders). Using Helpers we hope that users can read with less verbose the Builders classes. On below we have an example of what we expect with Helpers:

```#ruby
class ExamplesBuilder

  def initialize; scrap_examples(element); end;

  def scrap_examples(element) 
    scrap_x_data(element);
    scrap_y_data(element);
  end

  def scrap_x_data(element); ...; end

  def scrap_y_data(element)
    # some code
    extract_y_data_from_text(text_element)
  end

  # this method belongs to Helpers because its purpose is to encapsulate some code that belongs only to the meaningful named method "scrap_y_data", and letting that method here only inscreases the class size. You can think as Helpers used here related to the concept of Views and Helpers on Rails.
  def extract_y_data_from_string
    # some code
  end
end
```
