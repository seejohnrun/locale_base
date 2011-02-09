module LocaleBase

  class Translator

    # Initialize a new LocaleBase for translating
    # locale files
    #
    # +hash+ The object to convert
    def initialize(hash = [])
      @original = hash
    end

    # place track tokens
    # translate all of them
    # and then replace the tokens with their string equivelants
    def translate(options = {})

      tracker = TranslationTracker.new
      
      # we use divs here instead of spans so that google doesn't mess us up
      # by combining spans on requests
      @created = crazy_walk(@original) do |obj|
        obj.gsub!(/%\{([^\}]+)\}/) do |m|
          "<div class='notranslate'>#{tracker.hold($1)}</div>"
        end
        # insert trackers
        tracker.track(obj)
      end

      # translate everything
      tracker.translate_all(options)
      
      # replace the tokens with the tranlated text
      @created = crazy_walk(@created) do |obj|
        obj = tracker.retrieve(obj) if obj.is_a?(TrackingToken)
        # remove divs and replace with hold text - don't let google near this stuff
        # whitespace split also needed cause google messess with our shit
        obj.gsub!('><', '> <')
        obj.gsub!('> .', '>.')
        obj.gsub!(/<div\sclass='notranslate'>([^<]+)<\/div>/) do |m|
          "%{#{tracker.unhold($1)}}"
        end
        
        obj
      end

    end

    private

    # nice little recursive walker
    def crazy_walk(obj, &block)
      if obj.is_a?(Array)
        obj.map { |item| crazy_walk(item, &block) }
      elsif obj.is_a?(Hash)
        hash = Hash.new
        obj.each_pair { |key, value| hash[key] = crazy_walk(value, &block) }
        hash
      else
        yield obj
      end
    end
    
  end

end
