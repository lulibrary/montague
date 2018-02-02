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

```ruby
# without API key
client = Montague::API::Client.new
# with API key
client = Montague::API::Client.new api_key: 'YOUR_API_KEY'
```

#### Find by journal ISSN
```ruby
report = client.find_by_journal_issn '1550-7998'
#=> #<Montague::Model::JournalsReport:0x00c0ffee ...>
report.journals.size
#=> 1
report.journals
#=> [#<Montague::Model::Journal:0x00c0ffee @title="Physical Review D - Particles, Fields, Gravitation and Cosmology", @issn="1550-7998">]
publisher = report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
publisher.name
#=> "American Physical Society"
publisher.conditions
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
#=> #<Montague::Model::JournalsReport:0x00c0ffee ...>
report.journals.size
#=> 13
report.publisher
#=> nil
```

#### Find by publisher name
```ruby
report = client.find_by_publisher_name name: 'institute', filter: :exact
#=> #<Montague::Model::PublishersReport:0x00c0ffee ...>
report.publishers.size
#=> 122
```

#### Find by publisher ID (RoMEO)
```ruby
report = client.find_by_publisher_id 10
#=> #<Montague::Model::PublisherReport:0x00c0ffee ...>
report.publisher
#=> #<Montague::Model::Publisher:0x00c0ffee ...>
```

#### Inspecting reports
```ruby
report.header
#=> #<Montague::Model::Header:0x00c0ffee @api_control="journal", @hits=1, @message=nil, @outcome="singleJournal">
report.http_response
#=> #<HTTP::Response/1.1 200 OK {"Date"=>"Fri, 02 Feb 2018 11:34:38 GMT", "Server"=>"Apache/2.4.7 (Ubuntu)", "X-Powered-By"=>"PHP/5.5.9-1ubuntu4.22", "Access-Control-Allow-Origin"=>"*", "Vary"=>"Accept-Encoding", "Content-Length"=>"5056", "Connection"=>"close", "Content-Type"=>"text/xml"}>
```