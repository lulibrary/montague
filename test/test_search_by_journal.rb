require 'test_helper'

class TestSearchByJournal < Minitest::Test

  def test_find_by_title_contains_with_api_key
    # title (partial): modern language
    journals = Montague::API::Journal.new config
    x = journals.find_by_title text: 'modern language', filter: :contains

    asserts_journals_report x
  end

  def test_find_by_title_starts_with_api_key
    # title (partial): Machine
    journals = Montague::API::Journal.new config
    x = journals.find_by_title text: 'Machine', filter: :starts

    asserts_journals_report x
  end

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    journals = Montague::API::Journal.new config
    x = journals.find_by_title text: 'chemistry', filter: :exact

    asserts_journals_report x

    # puts x.inspect
  end

  def test_find_by_title_unique_with_api_key
    # title: Man
    journals = Montague::API::Journal.new config
    x = journals.find_by_title text: 'Man', filter: :exact

    asserts_publisher_found x
    asserts_journals_report x
  end

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    journals = Montague::API::Journal.new config
    x = journals.find_by_issn('1550-799')

    asserts_journal_report x
    assert_equal 0, x.header.hits
  end

  def test_find_by_issn_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    journals = Montague::API::Journal.new
    x = journals.find_by_issn('1550-7998')

    asserts_publisher_found x
    asserts_journal_report x
  end

  def test_find_by_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    journals = Montague::API::Journal.new config
    x = journals.find_by_issn('1550-7998')

    asserts_publisher_found x
    asserts_journal_report x
  end

  def test_alternate_issn_values_with_api_key
    # title: Education and Urban Society
    # issn: 0013-1245
    journals = Montague::API::Journal.new config
    x = journals.find_by_issn('1552-3535,0013-1245')

    asserts_journal_report x
  end

  def test_mandates_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    journals = Montague::API::Journal.new config
    x = journals.find_by_issn('0022-1376')

    mandates = x.publisher.mandates
    assert_instance_of Array, mandates
    refute_empty mandates
    assert_instance_of Montague::Model::Mandate, mandates.first
    assert_equal true, mandates.first.data?
  end

end