require 'test_helper'

class TestPublisherAPI < Minitest::Test

  def asserts_publisher(x)

    # puts x.inspect

    assert_instance_of Montague::Model::Publisher, x

    assert_instance_of Array, x.conditions
    assert_instance_of String, x.conditions.first

    assert_instance_of Array, x.copyright_links
    assert_instance_of Montague::Model::CopyrightLink, x.copyright_links.first
    assert_equal true, x.copyright_links.first.data?

    assert_instance_of Fixnum, x.id

    assert_instance_of Array, x.mandates

    assert_instance_of String, x.name
    refute_empty x.name

    assert_instance_of Montague::Model::PaidAccess, x.paid_access
    assert_equal true, x.paid_access.data?

    assert_instance_of Montague::Model::Archiving, x.pdf_version
    assert_equal true, x.pdf_version.data?

    assert_instance_of Montague::Model::Archiving, x.post_prints
    assert_equal true, x.post_prints.data?

    assert_instance_of Montague::Model::Archiving, x.pre_prints
    assert_equal true, x.pre_prints.data?

    assert_instance_of String, x.romeo_colour
    refute_empty x.romeo_colour
  end

  def asserts_publisher_report(x)
    asserts_journal x.journal
    asserts_publisher x.publisher
  end

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    api = Montague::API::Publisher.new config
    x = api.find_by_journal_issn('1550-799')

    assert_instance_of NilClass, x
  end

  def test_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Publisher.new
    x = api.find_by_journal_issn('1550-7998')

    asserts_publisher_report x
  end
  
  def test_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Publisher.new config
    x = api.find_by_journal_issn('1550-7998')

    asserts_publisher_report x
  end

  def test_alternate_values_with_api_key
    # title: Education and Urban Society
    # issn: 0013-1245
    api = Montague::API::Publisher.new config
    x = api.find_by_journal_issn('1552-3535,0013-1245')

    asserts_publisher_report x
  end

  def test_mandates_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Publisher.new config
    x = api.find_by_journal_issn('0022-1376').publisher

    assert_instance_of Array, x.mandates
    refute_empty x.mandates
    assert_instance_of Montague::Model::Mandate, x.mandates.first
    assert_equal true, x.mandates.first.data?
  end

  def test_find_by_title_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Publisher.new config
    x = api.find_by_journal_title_exact('Journal of Geology')

    asserts_publisher_report x
  end

  def test_client_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    client = Montague::API::Client.new config
    x = client.publishers.find_by_journal_issn('1550-7998')

    asserts_publisher_report x
  end

  def test_find_by_name_all_with_api_key
    words = 'optical society'
    api = Montague::API::Publisher.new config
    x = api.find_by_name_all words

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::Publisher, x.first
  end

  def test_find_by_name_any_with_api_key
    words = 'chemistry society'
    api = Montague::API::Publisher.new config
    x = api.find_by_name_any words

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::Publisher, x.first
  end

  def test_find_by_name_exact_with_api_key
    words = 'tute of'
    api = Montague::API::Publisher.new config
    x = api.find_by_name_exact words

    assert_instance_of Array, x
    refute_empty x
    assert_instance_of Montague::Model::Publisher, x.first
  end

  def test_find_by_id_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # id: 10
    id = 10
    api = Montague::API::Publisher.new config
    x = api.find_by_id id

    asserts_publisher x
  end

end