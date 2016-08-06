#!/usr/local/bin/env ruby

# Require the files that requires all the other files and the initialize the constants

require_relative '../email/lib/lists/require/require'
require_relative '../email/lib/lists/require/constants'

# Optparse to append the flags into the OPTIONS constant

OptionParser.new do |opts|
  opts.on('--tutorial', 'First time with the program..? Run this and find out how to use it') { |o| OPTIONS[:tutorial] = o }
  opts.on('--help', 'Generate the help page') { |o| OPTIONS[:help] = o }
  opts.on('-t INPUT[=INPUT]', '--type INPUT[=INPUT]', 'Specify the type of email to be generated') { |o| OPTIONS[:type] = o }
  opts.on('--example', 'Gives an example of a generic email that was created using this program') { |o| OPTIONS[:example] = o }
  opts.on('--version', 'Displays the version number of the program') { |o| OPTIONS[:version] = o }
  opts.on('--test', 'Run the test modules.') { |o| OPTIONS[:test] = o }
end.parse!

def help_page
  puts
  puts "\e[44mruby gen_email.rb -[t] <Type-of-email> --[help|tutorial|test|example|version]\e[0m"
  `notepad.exe readme.md` unless File.read('./lib/tools/read.txt').chomp == 'true'
end

# Most of these are used for information gathering and are called in other modules, such as the email templates module.
# They are just basic questions and might be moved to their own module to save lines.

def res_group
  FORMAT.prompt('Enter resolution group').split.map(&:capitalize).join(' ')
end

def users_name
  FORMAT.prompt('Enter users full name').split.map(&:capitalize).join(' ')
end

def cap_name(name)
  name.split.map{ |i| i.capitalize }.join(' ')
end

def summary
  FORMAT.prompt('Enter summary of issue')
end

def poc_name
  FORMAT.prompt('Enter POC name').downcase
end

def dev_domain
  FORMAT.prompt('Enter domain name')
end

def dev_server
  FORMAT.prompt('Enter server name')
end

def request_cancel
  print "\e[36mEnter ticket num to cancel:\e[0m INC00000"
  cancel = STDIN.gets.chomp
  verify_digits(cancel)
end

# Verify that the digits are correctly entered, it will not allow more then 7 digits entered at a time.

def verify_digits(int)
  begin
    if !(int[/^\d{7}$/])
      raise TicketNumError
    else
      int
    end
  rescue TicketNumError
    '<Invalid ticket number>'
  end
end

def num
  print "\e[36mEnter ticket num:\e[0m INC00000"
  num = STDIN.gets.chomp
  verify_digits(num)
end

# Verify that the timestamp is in the same format as the Remedy systems timestamp format. This will save the user
# a lot of trouble by making them input the correct timestamp before they send the email.

def verify_timestamp(stamp)
  begin
    if !(stamp[/^\d{1,2}\/\d{1,2}\/\d{4} \d{1,2}:\d{1,2}:\d{1,2} [AP]M\z/])
      FORMAT.warning('Invalid format of timestamp example: 06/07/2016 5:30:23 AM')
      raise TimeStampFormatError
    else
      stamp
    end
  rescue TimeStampFormatError
    timestamp
  end
end

def timestamp
  print "\e[36mEnter timestamp for removal: \e[0m"
  ts = STDIN.gets.chomp.upcase
  verify_timestamp(ts)
end

def body
  FORMAT.prompt('Enter what will happen or what you did')
end

def res
  FORMAT.prompt('Enter resolution')
end

def account
  FORMAT.prompt('Enter users account')
end

def user_id
  FORMAT.prompt('Enter username')
end

def agency
  FORMAT.prompt('Enter users agency')
end

def phone_num
  FORMAT.prompt('Enter users phone number')
end

def check_date
  SKIPDAY.date
end

def header
  CHECKTIME.check_time
end

def get_user
  user = Etc.getlogin
  @esd_user = user.split('_').first.capitalize + ' ' + user.split('_').last[0].upcase
end

def copy(email)
  clip = ClipBrd::CopyToClipboard.new
  File.open('./lib/tools/tmp/email_to_copy', 'w') { |s| s.puts(email) }
  clip.copy_to_clipbrd
  FORMAT.info('Copied to clipboard press CNTRL-V to paste')
end

def advocate_agency
  print "\e[36mEnter agency:\e[0m "
  STDIN.gets.chomp.upcase
end

# Gets the advocates and POC's from YAML files located inside of the lib/list dir. The YAML files contains every
# advocate for every agency and every POC inbox, email, and phone number.

def get_advocate
  res = advocate_agency
  file = YAML.load_file('lib/lists/advocate_list.yml')
  begin
    if file['agencies'][res] == nil
      raise InvalidPocError
    else
      file['agencies'][res]
    end
  rescue InvalidPocError
    'Invalid POC'
  end
end

def get_poc_inbox(name)

  data = [POC_INBOX['poc_inbox'][name.downcase]].flatten

  if data.count == 1
    POC_INBOX['poc_inbox'][name]
  else
    FORMAT.warning("Multiple inbox's found for #{cap_name(name)}")
    data.each.with_index(1) do |str, i|
      FORMAT.info("#{i}. #{str}")
    end
    FORMAT.warning("One of the above inbox's is the correct inbox for this ticket.")
    '<PASTE INBOX HERE>'
  end
end

def get_poc_num(name)
  data = POC_NUM['poc_phone'][name]
  begin
    if data.kind_of?(String)
      data
    else
      raise InvalidPocError
    end
  rescue InvalidPocError
    "** POC #{name} does not have a number listed **"
  end
end

def get_poc_email(name)
  data = POC_EMAIL['poc_email'][name]
  begin
    if data.kind_of?(String)
      data
    else
      raise InvalidPocError
    end
  rescue InvalidPocError
    "** POC #{name} does not have an email listed **"
  end
end

# Figure out the email type, by finding the flag argument and comparing it against a regex to validate what the user
# wants to do. For example: ruby gen_email.rb -t generic <= Will create a generic email to be sent, and copy it to the
# users clipboard.

def gather_intel
  case OPTIONS[:type]
    when /osha/
      FORMAT.info('Creating OSHA Regional email..')
      EMAILS.osha_reg
    when /pend/
      FORMAT.info('Creating 6 day hold pending email..')
      EMAILS.pend
    when /60/
      FORMAT.info('Creating 60 day hold account deletion email..')
      EMAILS.sixty_day
    when /generic/
      FORMAT.info('Creating generic email..')
      EMAILS.generic
    when /resolve/
      FORMAT.info('Creating resolution ticket..')
      EMAILS.resolve
    when /esc/
      FORMAT.info('Creating escalation ticket..')
      EMAILS.assign
    when /pii/
      FORMAT.info('Creating request to remove personal info..')
      EMAILS.remove_pii
    when /vip/
      FORMAT.info('Creating VIP user email..')
      EMAILS.vip_user
    when /inop/
      FORMAT.info('Creating INOP user email..')
      EMAILS.in_op_user
    when /dev/
      begin
        if OPTIONS[:type].to_s.include?('dev=unlock')
          message = 'unlock'
        elsif OPTIONS[:type].to_s.include?('dev=reset')
          message = 'password reset'
        else
          raise InvalidDevRequestError
        end
        FORMAT.info("Creating dev account #{message} email")
        EMAILS.dev_account(OPTIONS[:type])
      rescue InvalidDevRequestError
        FORMAT.err("#{OPTIONS[:type].to_s.split('=').last} is not a valid dev email, please try again..")
      end
    when /cancel/
      FORMAT.info('Creating cancellation request..')
      EMAILS.cancel_ticket
    else
      raise InvalidOptionError
  end
end

# Where all the big decisions are made, after the program has appended into the OPTIONS constant it will then look at
# the info called here. If nothing is given it will default to the help page method

begin
  case
    when OPTIONS[:type]
      README.check_if_read
      gather_intel
    when OPTIONS[:example]
      puts "\e[36m#{EMAILS.examples_page}\e[0m"
    when OPTIONS[:version]
      puts VERSION.version
    when OPTIONS[:test]
      TESTRUN.run_test
    when OPTIONS[:tutorial]
      TUT.flag_choices
    else
      puts help_page
  end
rescue => e
  FORMAT.err("Program failed due to #{e}")
  FORMAT.err("ERROR => #{e.backtrace.join}")
  FORMAT.info('To report this issue, fill out the text file called Issues.txt in the /lib/text_files directory.')
end