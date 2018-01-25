require 'test_helper'

class TestFindByISSN < Minitest::Test

  def test_invalid_issn_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998 (INCOMPLETE)
    api = Montague::API::Journal.new config
    x = api.find_by_issn '1550-799'

    assert_instance_of NilClass, x
  end  

  def test_without_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Journal.new
    x = api.find_by_issn '1550-7998'
    
    asserts_journal x
  end
  
  def test_with_api_key
    # title: Physical Review D - Particles, Fields, Gravitation and Cosmology
    # issn: 1550-7998
    api = Montague::API::Journal.new config
    x = api.find_by_issn '1550-7998'
    
    asserts_journal x
  end

  def test_alternate_values_with_api_key
    # title: Education and Urban Society
    # issn: 0013-1245
    api = Montague::API::Journal.new config
    x = api.find_by_issn '1552-3535,0013-1245'

    asserts_journal x
  end

  def test_mandates_with_api_key
    # title: Journal of Geology
    # issn: 0022-1376
    api = Montague::API::Journal.new config
    x = api.find_by_issn '0022-1376'

    assert_instance_of Array, x.mandates
    refute_empty x.mandates
    assert_instance_of Montague::Model::Mandate, x.mandates.first
    assert_equal true, x.mandates.first.data?
  end

end