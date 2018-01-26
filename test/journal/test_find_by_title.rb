require 'test_helper'

class TestFindByTitle < Minitest::Test

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Journal.new config
    x = api.find_by_title 'Journal of Geology'

    asserts_journal x
  end

  def test_find_by_partial_title_with_api_key
    # title (partial): modern language
    api = Montague::API::Journal.new config
    x = api.find_by_partial_title 'modern language'

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::JournalHeader, x.first
    assert_equal true, x.first.data?
  end
  
end