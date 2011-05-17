require 'helper'

class TestKNMI < KNMI::TestCase
  context "a station by location" do 
    setup do
      @station = KNMI.station_by_location(52.165, 4.419)
    end
    
    should "be a struct" do
      assert_equal @station.class, KNMI::Station
    end
    
    should 'find id 210' do
      assert_equal @station.id, 210
    end
  end
  
  context "a station by id" do 
    setup do
      @station = KNMI.station_by_id(210)
    end
    
    should "be a struct" do
      assert_equal @station.class, KNMI::Station
    end
    
    should 'find id 210' do
      assert_equal @station.id, 210
    end
    
  end
  
  
  # Test KNMI.Parameters Daily
  context "fetch daily - a single parameter" do
    setup do
      @params = KNMI.parameters(period = "daily", "TX")
    end
    
    should "be kind of Array" do
      assert_equal @params.class, Array
    end
    
    should "contain KNMI::Daily object" do
      assert_equal @params[0].class, KNMI::Parameters
    end
    
    should "be length 1" do
      assert_equal @params.length, 1
    end
    
    should "access parameter id" do
      assert_equal @params[0].parameter, "TX"
    end
    
    should "access category id" do
      assert_equal @params[0].category, "TEMP"
    end
    
    should "access description id" do
      assert_contains @params[0].description, "Maximum Temperature"
    end
    
    should "access validation equation" do
      assert_equal @params[0].validate, "n.integer?"
    end
    
    should "access conversion equation" do
      assert_equal @params[0].conversion, "n / 10"
    end
    
    should "access units" do
      assert_equal @params[0].units, "C"
    end
  end
    
  context "fetch daily - more than one parameter" do
    setup do
      @params = KNMI.parameters(period = "daily",["TX", "TG"])
    end
    
    should "be length 2" do
      assert_equal @params.length, 2
    end
  end
    
  context "fetch daily - one doubly named parameter" do
    setup do
      @params = KNMI.parameters(period = "daily", ["TX", "TX"])
    end
    
    should "be length 1" do
      assert_equal @params.length, 1
    end
  end

  context "fetch daily - a single parameter category" do
    setup do
      @params = KNMI.parameters(period = "daily", params = "", categories = "TEMP")
    end
    
    should "be length 7" do
      assert_equal @params.length, 7
    end
  end
  
  context "fetch daily - more than one parameter category" do
    setup do
      @params = KNMI.parameters(period = "daily", params = "", categories = ["TEMP", "WIND"])
    end
    
    should "be length 16" do
      assert_equal @params.length, 16
    end
  end
  
  context "fetch daily - one doubly named parameter category" do
    setup do
      @params = KNMI.parameters(period = "daily", params = "", categories = ["WIND", "WIND"])
    end
    
    should "be length 9" do
      assert_equal @params.length, 9
    end
  end
  
  context "fetch daily - a single parameter and a single parameter category of same grouping" do
    setup do
      @params = KNMI.parameters(period = "daily", params = "TX", categories = "TEMP")
    end
    
    should "be length 7" do
      assert_equal @params.length, 7
    end
  end
  
  context "fetch daily - an param or category which isn't available" do
    setup do
      @params = KNMI.parameters(period = "daily", "Tmax")
    end
    
    should "be length 0" do
      assert_equal @params.length, 0 
    end
  end
  
end