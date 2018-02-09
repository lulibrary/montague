# Montague

Wrapper for the SHERPA/RoMEO API.

## Status

[![Gem Version](https://badge.fury.io/rb/montague.svg)](https://badge.fury.io/rb/montague)
[![Maintainability](https://api.codeclimate.com/v1/badges/73f9d8be3f61882a8ec6/maintainability)](https://codeclimate.com/github/lulibrary/montague/maintainability)

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

Discover a publisher's copyright and archiving policies by searching for a publisher directly or by searching for a publisher indirectly via a journal.

<a href="http://www.sherpa.ac.uk/romeo.php"><img src="http://www.sherpa.ac.uk/images/romeosmall.jpg" width="100" height="54" alt="SHERPA/RoMEO Database" border="0"></a>

### Journal search
```ruby
# without API key
journals = Montague::API::Journal.new
# with API key
journals = Montague::API::Journal.new api_key: 'YOUR_API_KEY'
```

#### Find by journal ISSN

```ruby
report = journals.find_by_issn '1550-7998'
#=> #<Montague::Model::JournalReport:0x00c0ffee ...>
report.journal
#=> #<Montague::Model::Journal:0x00c0ffee @title="Physical Review D - Particles, Fields, Gravitation and Cosmology", @issn="1550-7998">
report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
report.publisher.name
#=> "American Physical Society"
report.publisher.conditions
#=> ["On author's personal website, employer's website or institutional repository", ...]
report.publisher.pre_prints
#=> #<Montague::Model::Archiving:0x00c0ffee @permission="can", @restrictions=[]>
report.publisher.romeo_colour
#=> "green"
report.publisher.mandates
#=> [#<Montague::Model::Mandate:0x00c0ffee @funder=#<Montague::Model::Funder:0x00c0ffee @name="Australian Research Council", @acronym="ARC">, @publisher_complies="yes", @compliance_type="Compliant", @selected_titles="no">, ...]
```

```ruby
# alternative numbers for a journal, typically ESSN and ISSN
report = journals.find_by_issn '1552-3535,0013-1245'
report.journal
#=> #<Montague::Model::Journal:0xb3969e8 @title="Education and Urban Society", @issn="0013-1245">
report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
```

#### Find by journal title
```ruby
report = journals.find_by_title text: 'modern language', filter: :contains
#=> #<Montague::Model::JournalsReport:0x00c0ffee ...>
report.journals.size
#=> 13
report.journals
#=> [#<Montague::Model::Journal:0xacf4aa4 @title="Canadian Modern Language Review / Revue canadian des langues vivantes", @issn="0008-4506">, ...]
report.publisher
#=> nil
```

```ruby
# example of when the publisher is not available for a journal
report = journals.find_by_title text: 'Man', filter: :exact
#=> #<Montague::Model::JournalsReport:0x00c0ffee ...>
report.journals.size
#=> 1
report.publisher
#=> nil
```

### Publisher search
```ruby
# without API key
publishers = Montague::API::Publisher.new
# with API key
publishers = Montague::API::Publisher.new api_key: 'YOUR_API_KEY'
```

#### Find by publisher name
```ruby
report = publishers.find_by_name text: 'institute', filter: :exact
#=> #<Montague::Model::PublishersReport:0x00c0ffee ...>
report.publishers.size
#=> 122
```

#### Find by publisher ID (RoMEO)
```ruby
report = publishers.find_by_id 10
#=> #<Montague::Model::PublisherReport:0x00c0ffee ...>
report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
```

### Search client
```ruby
# without API key
client = Montague::API::Client.new
# with API key
client = Montague::API::Client.new api_key: 'YOUR_API_KEY'
```

```ruby
report = client.journals.find_by_issn '1550-7998'
#=> #<Montague::Model::JournalReport:0x00c0ffee ...>
report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
```

### Inspecting reports
```ruby
report.header
#=> #<Montague::Model::Header:0x00c0ffee @api_control="journal", @hits=1, @message=nil, @outcome="singleJournal">
report.http_response
#=> #<HTTP::Response/1.1 200 OK {"Date"=>"Fri, 02 Feb 2018 11:34:38 GMT", "Server"=>"Apache/2.4.7 (Ubuntu)", "X-Powered-By"=>"PHP/5.5.9-1ubuntu4.22", "Access-Control-Allow-Origin"=>"*", "Vary"=>"Accept-Encoding", "Content-Length"=>"5056", "Connection"=>"close", "Content-Type"=>"text/xml"}>
```

