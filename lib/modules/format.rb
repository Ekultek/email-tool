# Color coordinate information handling. If it's red it's bad, if it's blue it's probably good.

module Format

  class InfoHandle

    # Basic information, not extremely vital so just call info.
    # @return [String]=String (for all occurrences)
    def info(input)
      puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] \e[36m#{input}\e[0m"
    end

    # Warning the user that something isn't exactly right.
    def warning(input)
      puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] \e[7m#{input}\e[0m"
    end

    # Prompt the user so I don't have to continuously type gets.chomp 100000 times..
    def prompt(input)
      print "\e[36m#{input}:\e[0m "
      STDIN.gets.chomp
    end

    # Error out of the program, usually followed by an 'exit' or user with a 'rescue'
    def err(input)
      puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] \e[31m#{input}\e[0m"
    end

  end

end