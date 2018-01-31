require 'test_helper'

class TestJournalAPI < Minitest::Test

  def test_find_by_title_contains_with_api_key
    # title (partial): modern language
    api = Montague::API::Journal.new config
    x = api.find_by_title title: 'modern language', query_type: :contains

    asserts_report x
  end

  def test_find_by_title_starts_with_api_key
    # title (partial): Machine
    api = Montague::API::Journal.new config
    x = api.find_by_title title: 'Machine', query_type: :starts

    asserts_report x
  end

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Journal.new config
    x = api.find_by_title title: 'chemistry', query_type: :exact

    asserts_report x

    # puts x.inspect
  end

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    api = Montague::API::Journal.new config
    x = api.find_by_issn('1550-799')

    asserts_report x
  end

  def test_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Journal.new
    x = api.find_by_issn('1550-7998')

    asserts_report x
  end

  def test_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Journal.new config
    x = api.find_by_issn('1550-7998')

    asserts_report x
  end

  def test_alternate_values_with_api_key
    # title: Education and Urban Society
    # issn: 0013-1245
    api = Montague::API::Journal.new config
    x = api.find_by_issn('1552-3535,0013-1245')

    asserts_report x
  end

  def test_mandates_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Journal.new config
    x = api.find_by_issn('0022-1376')

    mandates = x.publishers.first.mandates
    assert_instance_of Array, mandates
    refute_empty mandates
    assert_instance_of Montague::Model::Mandate, mandates.first
    assert_equal true, mandates.first.data?
  end

  def test_client_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    client = Montague::API::Client.new config
    x = client.journals.find_by_issn('1550-7998')

    asserts_report x
  end  
end