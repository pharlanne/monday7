require( 'minitest/autorun' )
require( 'minitest/rg' )
require_relative( '../models/shop' )
require_relative( '../models/pet' )

class TestPetshop < MiniTest::Test
## This is a mess!  

  def setup
    options = {
      "name" => 'shop1', 
      "stock_kind" => 'aquatic'
    }
    @shop = Shop.new( options )
    # @shop.save()

    # (0..4).each do |p|
    #   @pet = Pet.new({"name" => "juno", "species" => "fish", "shop_id" => @shop.id})
    #   @pet.save()
    # end

  end

  # def test_name()
  #   assert_equal( 'shope', @shop.name() )
  # end

  # def test_species()
  #   assert_equal( 'fish', @shop.stock_kind() )
  # end

  def test_max_pet()
    # Ummm......
    assert_equal( true, Shop.max_pets?(1) )
  end

end