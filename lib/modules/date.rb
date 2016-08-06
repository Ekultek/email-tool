# Makes sure that the day is a business day (Monday - Friday). If it is not then the day is skipped over during the
# process of when it is set.

module DateCheck

  class BusinessDay

    # @return [Integer]='5 business days from today'
    def date
      today = Date.today
      (1..Float::INFINITY) # Float to infinity
          .lazy # Get lazy
          .map { |offset| today + offset } # Map today from the offset
          .reject { |date| date.saturday? || date.sunday? } # Reject saturdays and sundays
          .drop(5) # Drop 5 from the mapped day
          .next
    end

  end

end