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

    assert_instance_of Montague::XMLExtractor::Journals, x
    assert_instance_of Array, x.journals
    refute_empty x.journals
    assert_instance_of Hash, x.journals.first
    assert_instance_of String, x.journals.first[:title]
    refute_empty x.journals.first[:title]
    assert_instance_of String, x.journals.first[:issn]
    refute_empty x.journals.first[:issn]
  end
  
end