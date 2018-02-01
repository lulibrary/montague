require 'test_helper'

class TestSearchByJournal < Minitest::Test

  def test_find_by_title_contains_with_api_key
    # title (partial): modern language
    api = Montague::API::Client.new config
    x = api.find_by_journal_title title: 'modern language', filter: :contains

    asserts_report x
  end

  def test_find_by_title_starts_with_api_key
    # title (partial): Machine
    api = Montague::API::Client.new config
    x = api.find_by_journal_title title: 'Machine', filter: :starts

    asserts_report x
  end

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Client.new config
    x = api.find_by_journal_title title: 'chemistry', filter: :exact

    asserts_report x

    # puts x.inspect
  end

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    api = Montague::API::Client.new config
    x = api.find_by_journal_issn('1550-799')

    asserts_report x
  end

  def test_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Client.new
    x = api.find_by_journal_issn('1550-7998')

    asserts_report x
  end

  def test_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Client.new config
    x = api.find_by_journal_issn('1550-7998')

    asserts_report x
  end

  def test_alternate_values_with_api_key
    # title: Education and Urban Society
    # issn: 0013-1245
    api = Montague::API::Client.new config
    x = api.find_by_journal_issn('1552-3535,0013-1245')

    asserts_report x
  end

  def test_mandates_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Client.new config
    x = api.find_by_journal_issn('0022-1376')

    mandates = x.publishers.first.mandates
    assert_instance_of Array, mandates
    refute_empty mandates
    assert_instance_of Montague::Model::Mandate, mandates.first
    assert_equal true, mandates.first.data?
  end

end