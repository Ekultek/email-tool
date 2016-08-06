# Header information, if it's 12:00 or later it says 'good afternoon' if it's earlier 'good morning'

module TimeCheck

  class CheckTime

    # Check what time it is, AM or PM. If it's AM say 'Good morning' else say 'Good afternoon'.
    # @return [String]='am' or 'pm'
    def check_time
      if Time.now.strftime('%P') == 'pm'
        'Good afternoon'
      else
        'Good morning'
      end
    end

  end

end