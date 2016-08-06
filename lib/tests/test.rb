# Run a series of tests on all the modules to make sure they are performing correctly.

module TestRun

  class Test

    # Basic message to let the user know what's about to happen.
    def message
      <<-_END_
	This is the test module, it will run a series of tests
	on the program to verify if everything is working as expected.
	
	If you happen to get an error, log the error in the Issue.txt
	and follow the instructions on reporting an issue.
      _END_
    end

    # Start the test runs.
    def run_test
      failed = 0

      puts "\e[32m#{message}\e[0m"

      # Compare the versions to each other, if the version fails (which it shouldn't) add it to the list of failed tests
      begin
        puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Checking version.."
        version = VERSION.v_num
        if File.read('./lib/email/version.rb') =~ /#{version}/
          puts "\e[32mPASSED\e[0m"
        else
          raise "Version number did not correspond to #{version}"
          sleep(1)
        end
      rescue => e
        @version_error = e
        failed += 1
        puts "\e[31mFAILED\e[0m"
        sleep(1)
      end

      # Test the formatting to make sure they return true for math, and actually output information.
      begin
        puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Testing formatting module.."
        x = 5
        y = 5
        answer = 3125
        sleep(1)
        FORMAT.info("MATH TEST: #{x ** y == answer}")
        FORMAT.info("MODULE TEST")
        sleep(1)
        FORMAT.warning("MATH TEST: #{x ** y == answer}")
        FORMAT.warning("MODULE TEST")
        sleep(1)
        FORMAT.err("MATH TEST: #{x ** y == answer}")
        FORMAT.err("MODULE TEST")
        sleep(1)
        puts "\e[32mPASSED\e[0m" unless false
      rescue => e
        @format_error = e
        failed += 1
        puts "\e[31mFAILED\e[0m"
        sleep(1)
      end

      # Try to copy something. The only way this should fail is if the program itself is corrupt.
      begin
        puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Testing copying module.."
        message = 'CLIPBOARD TEST'
        copy(message)
        if File.read('./lib/tools/tmp/email_to_copy') != ''
          puts "\e[32mPASSED\e[0m"
        else
          raise "The copy module failed to copy #{message} from the temporary file."
        end
      rescue => e
        @clipboard_error = e
        failed += 1
        puts "\e[31mFAILED\e[0m"
        sleep(1)
      end

      # Check the time against itself. Make sure that the time is matching the time.
      begin
        puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Testing time modules.."
        test_time = CHECKTIME.check_time
        now_time = Time.now.strftime('%P')
        if now_time == 'pm'
          now_time = 'Good afternoon'
        else
          now_time = 'Good morning'
        end
        if test_time == now_time
          puts "\e[32mPASSED\e[0m"
          sleep(1)
        else
          raise "Time failed while being compared to the current time"
        end
      rescue => e
        @timecheck_error = e
        failed += 1
        puts "\e[31mFAILED\e[0m"
        sleep(1)
      end

      # Test the date to make sure it actually skips the correct days.
      begin
        puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Testing date modules.."
        test_date = SKIPDAY.date
        today = Date.today
        compare_date = (1..Float::INFINITY)
                           .lazy
                           .map { |offset| today + offset }
                           .reject { |date| date.saturday? || date.sunday? }
                           .drop(5)
                           .next
        if test_date == compare_date
          puts "\e[32mPASSED\e[0m"
          sleep(1)
        else
          raise "Date failed to compare to 6 buisness days from today."
        end
      rescue => e
        @date_check_error = e
        failed += 1
        puts "\e[31mFAILED\e[0m"
        sleep(1)
      end
      puts

      # Show all the errors, if none show 'nil'.
      puts "[\e[35m#{Time.now.strftime('%T')}\e[0m] Tests have all completed with #{failed} tests failed."
      FORMAT.info("Use the following as the error message (checkout the text_files directory issues.txt):")
      FORMAT.err("VERSION ERROR:   \e[31m#{@version_error} #{@version_error.backtrace.join}\e[0m") unless @version_error == nil; FORMAT.info('VERSION ERROR:   nil')
      FORMAT.err("FORMAT ERROR:    \e[31m#{@format_error} #{@format_error.backtrace.join}\e[0m") unless @format_error == nil; FORMAT.info('FORMAT ERROR:    nil')
      FORMAT.err("TIMECHECK ERROR: \e[31m#{@timecheck_error} #{@timecheck_error.backtrace.join}\e[0m") unless @timecheck_error == nil; FORMAT.info('TIMECHECK ERROR: nil')
      FORMAT.err("CLIPBOARD ERROR: \e[31m#{@clipboard_error} #{@clipboard_error.backtrace.join}\e[0m") unless @clipboard_error == nil; FORMAT.info('CLIPBOARD ERROR: nil')
      FORMAT.err("DATECHECK ERROR: \e[31m#{@date_check_error} #{@date_check_error.backtrace.join}\e[0m") unless @date_check_error == nil; FORMAT.info('DATECHECK ERROR: nil')
    end

  end

end  