require 'helper'

class TestApproximately < Test::Unit::TestCase
  include Approximately
  
  should "return an approximate object" do
    obj = approx(10)
    assert_kind_of Approximately::DeltaFloat, obj
    assert_kind_of Float, obj.to_f, "Should have stored a float in the attribute"
    assert_equal obj.float, obj.to_f
    assert_in_delta 10.0, obj.to_f, 0.01
  end
  
  should "compare to another float within delta" do
    d = 0.1
    assert_equal approx(1, d), approx(1, d), "Should be equal within delta"
    assert_equal approx(1, d), approx(0.95, d), "Should be equal within delta"
    assert_not_equal approx(1.0, d), approx(1.11, d), "Should not be equal outside delta"
  end
  
  should "compare to another float as a left-hand expression" do
    assert_equal approx(1.0, 0.1), 1.05, "Should be equal within delta"
  end
  
  should "compare to another float as a right-hand expression" do
    assert_equal 1.05, approx(1.0, 0.1), "Should be equal within delta"
  end
  
  should "create the object with default delta" do
    a = approx(0.013)
    assert_equal a.delta, Approximately::DEFAULT_DELTA
  end
end
