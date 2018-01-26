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
journal_api = Montague::API::Journal.new
# with API key
journal_api = Montague::API::Journal.new api_key: 'YOUR_API_KEY'
```

#### Find by ISSN
```ruby
journal = journal_api.find_by_issn '1550-7998'
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
journal = journal_api.find_by_issn '1552-3535,0013-1245'
journal.title
#=> "Education and Urban Society"
```

#### Find by title
```ruby
journal = journal_api.find_by_title 'Journal of Geology'
journal.issn
#=> "0022-1376"
```

#### Find by partial title
```ruby
journal_api.find_by_partial_title 'modern language'
#=> [#<Montague::Model::JournalHeader:0x00c0ffee @title="Canadian Modern Language Review / Revue canadian des langues vivantes", @issn="0008-4506">, ...]
```