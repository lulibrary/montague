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
journal = journals.find_by_issn '1550-7998'
journal.title
#=> "Physical Review D - Particles, Fields, Gravitation and Cosmology"
journal.publisher
#=> "American Physical Society"
journal.conditions
#=> ["On author's personal website, employer's website or institutional repository", ...]
journal.pre_prints
#=> #<Montague::Model::Archiving:0x00c0ffee @permission="can", @restrictions=[]>
journal.romeo_colour
#=> "green"
journal.mandates
#=> [#<Montague::Model::Mandate:0x00c0ffee @funder=#<Montague::Model::Funder:0x00c0ffee @name="Australian Research Council", @acronym="ARC">, @publisher_complies="yes", @compliance_type="Compliant", @selected_titles="no">, ...]
```

```ruby
# alternative numbers for a journal, typically ESSN and ISSN
journal = journals.find_by_issn '1552-3535,0013-1245'
journal.title
#=> "Education and Urban Society"
```

#### Find by title
```ruby
journal = journals.find_by_title 'Journal of Geology'
journal.issn
#=> "0022-1376"
```

#### Find by partial title
```ruby
journals.find_by_partial_title 'modern language'
#=> [#<Montague::Model::JournalHeader:0x00c0ffee @title="Canadian Modern Language Review / Revue canadian des langues vivantes", @issn="0008-4506">, ...]
```

### API Client
```ruby
# without API key
api = Montague::API::Client.new
# with API key
api = Montague::API::Client.new api_key: 'YOUR_API_KEY'
```

```ruby
journal = api.journals.find_by_issn '1550-7998'
```