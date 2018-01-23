require 'test_helper'

class TestFindByISSN < Minitest::Test

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    api = Montague::API.new config
    x = api.find_by_issn '1550-799'

    assert_instance_of NilClass, x
  end  

  def test_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API.new
    x = api.find_by_issn '1550-7998'
    
    asserts_journal x
  end
  
  def test_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API.new config
    x = api.find_by_issn '1550-7998'
    
    asserts_journal x
  end
  
end