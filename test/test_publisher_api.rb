require 'test_helper'

class TestPublisherAPI < Minitest::Test

  def test_find_by_name_all_with_api_key
    api = Montague::API::Publisher.new config
    x = api.find_by_name name: 'optical society', query_type: :all

    asserts_report x
    asserts_publisher_focus x
  end

  def test_find_by_name_any_with_api_key
    api = Montague::API::Publisher.new config
    x = api.find_by_name name: 'chemistry society', query_type: :any

    asserts_report x
    asserts_publisher_focus x
  end

  def test_find_by_name_exact_with_api_key
    api = Montague::API::Publisher.new config
    x = api.find_by_name name: 'tute of', query_type: :exact

    asserts_report x
    asserts_publisher_focus x
  end

  def test_find_by_id_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # id: 10
    id = 10
    api = Montague::API::Publisher.new config
    x = api.find_by_id id

    asserts_report x
    asserts_publisher_focus x
  end

end