# Require all the libraries and the modules to make the program run successfully.

require 'date'
require 'etc'
require 'optparse'
require 'io/console'
require 'yaml'

require_relative '../../../../email/lib/modules/clipboard'
require_relative '../../../../email/lib/modules/date'
require_relative '../../../../email/lib/modules/format'
require_relative '../../../../email/lib/modules/time'
require_relative '../../../../email/lib/email/version'
require_relative '../../../../email/lib/modules/email_templates'
require_relative '../../../../email/lib/tests/test'
require_relative '../../../../email/lib/modules/readme'
require_relative '../../../../email/lib/modules/first'
require_relative '../../../../email/lib/errors/error_classes'

include Format
include DateCheck
include TimeCheck
include ClipBrd
include Email
include Templates
include TestRun
include ReadMe
include FirstTime