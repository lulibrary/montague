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

The ultimate aim is to find a publisher and to determine its copyright and archiving policies.
This can be achieved by searching for a publisher directly or via a journal.

* ```Montague::Model::Report``` object is returned from all searches (let's call it ```report```).
* ```report.header.hits``` - results found (journals or publishers) depending whether
journal or publisher properties are used in the search.
* ```report.journals.size``` and ```report.publishers.size```  indicate the search success.
* ```report.header.message``` - details any problem.
* For all searches, a publisher is found when the ```report.publishers``` returns
a single element array.

```ruby
# without API key
client = Montague::API::Client.new
# with API key
client = Montague::API::Client.new api_key: 'YOUR_API_KEY'
```

#### Find by journal ISSN
```ruby
report = client.find_by_journal_issn '1550-7998'
#=> #<Montague::Model::Report:0x00c0ffee ...>
report.header.hits
#=> 1
report.header.message
#=> nil
report.journals.size
#=> 1
report.journals
#=> [#<Montague::Model::Journal:0x00c0ffee @title="Physical Review D - Particles, Fields, Gravitation and Cosmology", @issn="1550-7998">]
report.publishers.size
#=> 1
publisher = report.publishers.first
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
publisher.name
#=> "American Physical Society"
publisher.name
#=> ["On author's personal website, employer's website or institutional repository", ...]
publisher.pre_prints
#=> #<Montague::Model::Archiving:0x00c0ffee @permission="can", @restrictions=[]>
publisher.romeo_colour
#=> "green"
publisher.mandates
#=> [#<Montague::Model::Mandate:0x00c0ffee @funder=#<Montague::Model::Funder:0x00c0ffee @name="Australian Research Council", @acronym="ARC">, @publisher_complies="yes", @compliance_type="Compliant", @selected_titles="no">, ...]
```

```ruby
# alternative numbers for a journal, typically ESSN and ISSN
report = client.find_by_journal_issn '1552-3535,0013-1245'
```

#### Find by journal title
```ruby
report = client.find_by_journal_title title: 'modern language', filter: :contains
#=> #<Montague::Model::Report:0x00c0ffee ...>
report.journals.size
#=> 13
report.publishers.size
#=> 0
```

#### Find by publisher name
```ruby
report = client.find_by_publisher_name name: 'institute', filter: :exact
#=> #<Montague::Model::Report:0x00c0ffee ...>
report.journals.size
#=> 0
report.publishers.size
#=> 122
```

#### Find by publisher ID (RoMEO)
```ruby
report = client.find_by_publisher_id '10'
#=> #<Montague::Model::Report:0x00c0ffee ...>
report.journals.size
#=> 0
report.publishers.size
#=> 1
```