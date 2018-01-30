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

  assert_instance_of String, x.issn
  refute_empty x.issn

  assert_instance_of String, x.title
  refute_empty x.title
end