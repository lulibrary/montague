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
  assert_instance_of Montague::Model::Journal, x

  assert_instance_of Array, x.conditions
  assert_instance_of String, x.conditions.first

  assert_instance_of Array, x.copyright_links
  assert_instance_of Montague::Model::CopyrightLink, x.copyright_links.first
  assert_equal true, x.copyright_links.first.data?

  assert_instance_of String, x.issn
  refute_empty x.issn

  assert_instance_of Array, x.mandates

  assert_instance_of Montague::Model::PaidAccess, x.paid_access
  assert_equal true, x.paid_access.data?

  assert_instance_of Montague::Model::Archiving, x.pdf_version
  assert_equal true, x.pdf_version.data?

  assert_instance_of Montague::Model::Archiving, x.post_prints
  assert_equal true, x.post_prints.data?

  assert_instance_of Montague::Model::Archiving, x.pre_prints
  assert_equal true, x.pre_prints.data?

  assert_instance_of String, x.publisher
  refute_empty x.publisher

  assert_instance_of String, x.romeo_colour
  refute_empty x.romeo_colour

  assert_instance_of String, x.title
  refute_empty x.title
end