require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib)

require 'montague'

def config
  {
      api_key: ENV['MONTAGUE_API_KEY'],
  }
end

def asserts_journal(x)
  assert_instance_of Montague::XMLExtractor::Journal, x

  assert_instance_of Fixnum, x.hits
  assert_equal 1, x.hits

  assert_instance_of Array, x.conditions
  assert_instance_of String, x.conditions.first

  assert_instance_of Array, x.copyright_links
  refute_empty x.copyright_links
  assert_instance_of String, x.copyright_links.first[:text]
  assert_instance_of String, x.copyright_links.first[:url]

  assert_instance_of String, x.issn
  refute_empty x.issn

  assert_instance_of Array, x.mandates

  assert_instance_of Hash, x.paid_access
  refute_empty x.paid_access
  assert_instance_of String, x.paid_access[:url]
  refute_empty x.paid_access[:url]
  assert_instance_of String, x.paid_access[:name]
  refute_empty x.paid_access[:name]
  assert_instance_of String, x.paid_access[:notes]
  refute_empty x.paid_access[:notes]

  assert_instance_of Hash, x.pdf_version
  refute_empty x.pdf_version
  assert_instance_of String, x.pdf_version[:archiving]
  refute_empty x.pdf_version[:archiving]
  assert_instance_of Array, x.pdf_version[:restrictions]
  assert_empty x.pdf_version[:restrictions]

  assert_instance_of Hash, x.post_prints
  refute_empty x.post_prints
  assert_instance_of String, x.post_prints[:archiving]
  refute_empty x.post_prints[:archiving]
  assert_instance_of Array, x.post_prints[:restrictions]
  assert_empty x.post_prints[:restrictions]

  assert_instance_of Hash, x.pre_prints
  refute_empty x.pre_prints
  assert_instance_of String, x.pre_prints[:archiving]
  refute_empty x.pre_prints[:archiving]
  assert_instance_of Array, x.pre_prints[:restrictions]
  assert_empty x.pre_prints[:restrictions]

  assert_instance_of String, x.publisher
  refute_empty x.publisher

  assert_instance_of String, x.romeo_colour
  refute_empty x.romeo_colour

  assert_instance_of String, x.title
  refute_empty x.title
end