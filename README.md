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

```ruby
api = Montague::API.new
result = api.find_by_issn '1550-7998'
result.name
#=> "American Physical Society"
result.conditions
#=> ["On author's personal website, employer's website or institutional repository", ...]
result.pre_prints
#=> {:archiving=>"can", :restrictions=>[]}
result.romeo_colour
#=> "green"
```

Using an API key.

```ruby
api = Montague::API.new api_key: 'YOUR_API_KEY'
```