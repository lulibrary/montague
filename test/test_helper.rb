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