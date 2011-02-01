module LocaleBase

  # VVV this is pretty awesome
  
  # analyze performance implications
  # TODO consider using a hash instead of any array - may have performance help
  # on many duplicates in yaml file - is that a use case that's valid?
  # is there a better structure?
  class TranslationTracker

    def initialize
      @tracking_array = []
      @holdings = {}
    end

    # translate every token
    # TODO make translate! in easy translate
    # TODO move out of this class and into the Base**
    def translate_all(options)
      @tracking_array = EasyTranslate.translate(@tracking_array, options.merge(:html => true))
    end

    # for things that should be hidden and not translated
    # return they key that will be put in place and unheld later
    #
    # Note: this workaround is needed due to how google translate
    # doesn't cleanly handle .notranslate spans
    def hold(value)
      key = "h%020x" % rand(1 << 80)
      @holdings[key] = value
      key
    end

    def unhold(key)
      @holdings[key]
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
