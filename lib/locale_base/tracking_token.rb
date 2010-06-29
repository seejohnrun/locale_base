module LocaleBase

  class TrackingToken
    
    attr_reader :position
    
    def initialize(tracker, position)
      @tracker = tracker
      @position = position
    end
    
    def to_s
      @tracker.retrieve(self)
    end
    
  end  

end
