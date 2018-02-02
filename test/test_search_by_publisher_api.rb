require 'test_helper'

class TestSearchByPublisher < Minitest::Test

  def test_find_by_name_all_with_api_key
    publishers = Montague::API::Publisher.new config
    x = publishers.find_by_name text: 'optical society', filter: :all

    asserts_publishers_report x
  end

  def test_find_by_name_any_with_api_key
    publishers = Montague::API::Publisher.new config
    x = publishers.find_by_name text: 'chemistry society', filter: :any

    asserts_publishers_report x
  end

  def test_find_by_name_exact_with_api_key
    publishers = Montague::API::Publisher.new config
    x = publishers.find_by_name text: 'tute of', filter: :exact

    asserts_publishers_report x
  end

  def test_find_by_id_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # id: 10
    id = 10
    publishers = Montague::API::Publisher.new config
    x = publishers.find_by_id id

    asserts_publisher_report x
  end

end