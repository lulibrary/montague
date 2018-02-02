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

def asserts_publisher(x)

  # puts x.inspect

  assert_instance_of Montague::Model::Publisher, x

  assert_instance_of String, x.alias if x.alias

  assert_instance_of Array, x.conditions
  x.conditions.each { |i| assert_instance_of String, i}

  assert_instance_of Array, x.copyright_links
  x.copyright_links.each { |i| assert_instance_of Montague::Model::CopyrightLink, i}

  assert_instance_of String, x.id

  assert_instance_of Array, x.mandates

  assert_instance_of String, x.name
  refute_empty x.name

  assert_instance_of Montague::Model::PaidAccess, x.paid_access if x.paid_access
  # assert_equal true, x.paid_access.data?

  assert_instance_of Montague::Model::Archiving, x.pdf_version
  assert_equal true, x.pdf_version.data?

  assert_instance_of Montague::Model::Archiving, x.post_prints
  assert_equal true, x.post_prints.data?

  assert_instance_of Montague::Model::Archiving, x.pre_prints
  assert_equal true, x.pre_prints.data?

  assert_instance_of String, x.romeo_colour
  refute_empty x.romeo_colour
end

def asserts_journal(x)
  assert_instance_of Montague::Model::Journal, x

  assert_instance_of String, x.issn if x.issn

  assert_instance_of String, x.title
  refute_empty x.title
end

def asserts_header(x)
  assert_instance_of Montague::Model::Header, x

  assert_instance_of Fixnum, x.hits

  assert_instance_of String, x.message if x.message

  assert_instance_of String, x.outcome
  refute_empty x.outcome
end

def asserts_journal_report(x)
  x.journals.each { |i| asserts_journal i }
  asserts_publisher x.publisher if x.publisher
  assert_instance_of HTTP::Response, x.http_response
  asserts_header x.header
end

def asserts_publishers_report(x)
  x.publishers.each { |i| asserts_publisher i }
  assert_instance_of HTTP::Response, x.http_response
  asserts_header x.header
end

def asserts_publisher_report(x)
  asserts_publisher x.publisher
  assert_instance_of HTTP::Response, x.http_response
  asserts_header x.header
end