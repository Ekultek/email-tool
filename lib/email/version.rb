# Current version that gen_email is in, it will display with the syntax of ruby gen_email.rb --version

module Email

  class VersionNumber

    # Method for version number, used when testing to match the version against itself
    # @return [String]='Version number'
    def v_num
      '4.2.0.0'
    end

    # Outputs the version that the program is in
    # @return [String]='Outputs the program version'
    def version
      "\e[36mThis program is currently in version number: #{v_num}\e[0m"
    end

  end

end