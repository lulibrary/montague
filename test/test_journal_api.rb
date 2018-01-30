require 'test_helper'

class TestJournalAPI < Minitest::Test

  def test_find_by_title_contains_with_api_key
    # title (partial): modern language
    api = Montague::API::Journal.new config
    x = api.find_by_title_contains 'modern language'

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::Journal, x.first
    assert_equal true, x.first.data?
  end

  def test_find_by_title_starts_with_api_key
    # title (partial): Machine
    api = Montague::API::Journal.new config
    x = api.find_by_title_starts 'Machine'

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::Journal, x.first
    assert_equal true, x.first.data?
  end
end