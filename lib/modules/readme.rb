# Force the user to read the readme.md. Mostly used just to make the user aware that there is help if they need it.

module ReadMe

  class CheckFile

    # Read the read.txt file
    def read_or_not?
      File.read('./lib/tools/read.txt')
    end

    # Check if the file contains 'true' or 'false'. If the file contains true, never open the readme again, but if the
    # file contains false, open the file with notepad.
    # @return [String]='true' or 'false'
    def check_if_read
      if read_or_not?.chomp == 'false'
        FORMAT.info("It looks like this is your first time using this program.
           Let's go ahead and get you familiar with the way it works. when you
           are ready to begin press enter..")
        STDIN.gets.chomp
        File.open('./lib/tools/read.txt', 'w') { |read| read.puts('true') }
        system('ruby gen_email.rb --tutorial')
      end
    end

  end

end