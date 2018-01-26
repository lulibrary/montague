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

### Journals API
```ruby
# without API key
journals = Montague::API::Journal.new
# with API key
journals = Montague::API::Journal.new api_key: 'YOUR_API_KEY'
```

#### Find by ISSN
```ruby
report = journals.find_by_issn '1550-7998'
report.journal
#=> #<Montague::Model::Journal:0x00c0ffee @title="Physical Review D - Particles, Fields, Gravitation and Cosmology", @issn="1550-7998">
report.publisher
#=> "American Physical Society"
report.conditions
#=> ["On author's personal website, employer's website or institutional repository", ...]
report.pre_prints
#=> #<Montague::Model::Archiving:0x00c0ffee @permission="can", @restrictions=[]>
report.romeo_colour
#=> "green"
report.mandates
#=> [#<Montague::Model::Mandate:0x00c0ffee @funder=#<Montague::Model::Funder:0x00c0ffee @name="Australian Research Council", @acronym="ARC">, @publisher_complies="yes", @compliance_type="Compliant", @selected_titles="no">, ...]
```

```ruby
# alternative numbers for a journal, typically ESSN and ISSN
report = journals.find_by_issn '1552-3535,0013-1245'
```

#### Find by title
```ruby
report = journals.find_by_title 'Journal of Geology'
```

#### Find by partial title
```ruby
journals.find_by_partial_title 'modern language'
#=> [#<Montague::Model::Journal:0x00c0ffee @title="Canadian Modern Language Review / Revue canadian des langues vivantes", @issn="0008-4506">, ...]
```

### API Client
```ruby
# without API key
api = Montague::API::Client.new
# with API key
api = Montague::API::Client.new api_key: 'YOUR_API_KEY'
```

```ruby
report = api.journals.find_by_issn '1550-7998'
```