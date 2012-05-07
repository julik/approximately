module Approximately
  VERSION = "1.0.0"
  DEFAULT_DELTA = 0.01
  
  # This object can be used for float comparisons. When
  # compared to another Float (or an object that responds to to_f)
  # it will be equal to that object if the float value of the ApproximateFloat
  # and the value being compared to are within a passed delta
  class DeltaFloat < Struct.new(:float, :delta)
    include Comparable
    
    def to_f
      float.to_f
    end
    
    def <=>(another)
      d = (to_f - another.to_f).abs
      return 0 if d < delta
      
      float <=> another.to_f
    end
  end
  
  def approx(float, delta = DEFAULT_DELTA)
    DeltaFloat.new(float, delta)
  end
end