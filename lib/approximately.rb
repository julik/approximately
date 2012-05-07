module Approximately
  VERSION = "1.0.0"
  DEFAULT_DELTA = 0.01
  
  # This object can be used for float comparisons. When
  # compared to another Float (or an object that responds to to_f)
  # it will be equal to that object if the float value of the ApproximateFloat
  # and the value being compared to are within a passed delta
  class DeltaFloat
    include Comparable
    attr_accessor :float, :delta
    alias_method :to_f, :float
    
    def initialize(float_value, delta)
      @float, @delta = float_value.to_f, delta
    end
    
    def to_f
      @float
    end
    
    def <=>(another)
      d = (@float - another.to_f).abs
      return 0 if d < delta
      float <=> another.to_f
    end
  end
  
  def approx(float, delta = DEFAULT_DELTA)
    DeltaFloat.new(float, delta)
  end
end