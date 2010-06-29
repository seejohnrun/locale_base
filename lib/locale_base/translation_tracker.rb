module LocaleBase

  # VVV this is pretty awesome
  
  # analyze performance implications
  # TODO consider using a hash instead of any array - may have performance help
  # on many duplicates in yaml file - is that a use case that's valid?
  # is there a better structure?
  class TranslationTracker

    def initialize
      @tracking_array = []
    end

    # translate every token
    # TODO make translate! in easy translate
    # TODO move out of this class and into the Base**
    def translate_all(options)
      @tracking_array = EasyTranslate.translate(@tracking_array, options.merge(:html => true))
    end
    
    def track(value)
      @tracking_array << value
      TrackingToken.new(self, @tracking_array.size - 1)
    end

    def retrieve(token)
      @tracking_array[token.position]
    end

  end

end
