require 'test_helper'

class TestFindByTitle < Minitest::Test

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API.new config
    x = api.find_by_title 'Journal of Geology'

    asserts_journal x
  end
  
end