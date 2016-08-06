# All the constants of the program used to make this thing run successfully. All the constants come from all the files
# and all the classes/modules. The OPTIONS constant is used as a placeholder for when the flags. Each flag is appended
# into the constants which gives the program a place to look when a flag is called upon.

POC_EMAIL = YAML.load_file('../email/lib/lists/poc_email_list.yml')
POC_NUM = YAML.load_file('../email/lib/lists/poc_phone_list.yml')
POC_INBOX = YAML.load_file('../email/lib/lists/poc_inbox_list.yml')
TESTRUN = TestRun::Test.new
EMAILS = Templates::EmailTypes.new
TUT = FirstTime::Tutorial.new(100)
VERSION = Email::VersionNumber.new
SKIPDAY = DateCheck::BusinessDay.new
CHECKTIME = TimeCheck::CheckTime.new
README = ReadMe::CheckFile.new
FORMAT = Format::InfoHandle.new

OPTIONS = {}