# Montague

Wrapper for the SHERPA RoMEO API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'montague'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install montague

## Usage

### Journal

```ruby
# without API key
api = Montague::API::Journal.new
# with API key
api = Montague::API::Journal.new api_key: 'YOUR_API_KEY'
```

#### Find by ISSN
```ruby
result = api.find_by_issn '1550-7998'
result.title
#=> "Physical Review D - Particles, Fields, Gravitation and Cosmology"
result.publisher
#=> "American Physical Society"
result.conditions
#=> ["On author's personal website, employer's website or institutional repository", ...]
result.pre_prints
#=> {:archiving=>"can", :restrictions=>[]}
result.romeo_colour
#=> "green"
result.mandates
#=> [{:funder_name=>"Australian Research Council", :funder_acronym=>"ARC", :publisher_complies=>"yes", :compliance_type=>"Compliant", :selected_titles=>""}, ...]
```

```ruby
# alternative numbers for a journal, typically ESSN and ISSN
result = api.find_by_issn '1552-3535,0013-1245'
result.title
#=> "Education and Urban Society"
```

#### Find by title
```ruby
result = api.find_by_title 'Journal of Geology'
result.issn
#=> "0022-1376"
```

#### Find by partial title
```ruby
result = api.find_by_partial_title 'modern language'
result.journals
#=> [{:title=>"Canadian Modern Language Review / Revue canadian des langues vivantes", :issn=>"0008-4506"}, ...]
```