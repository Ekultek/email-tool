# WARNING #

ALL INFORMATION HAS BEEN CHANGED TO PROTECT THE IDENTITY OF THOSE THAT ARE LISTED. PHONE NUMBERS, EMAILS, INBOXES, ETC
WILL NOT WORK. THIS IS TO DISPLAY THIS PROGRAM AND NOTHING MORE.

# TERMS OF SERVICE #

Whilst running this program you agree to the following:
  - You are liable for your own actions
  - You are running this program to verify the stackoverflow question posted here: http://codereview.stackexchange.com/questions/137995/emails-emails-everywhere
  - You will not in any way try to use any of the information gathered here for less then ethical purposes, including but not limited to, personal gain, hacking, ethical hacking, data mining, malicious intents of any kind.
  - You have been warned about the terms of service.
  - You agree that you are a stackoverflow user and have come here in order to look at the code of the program, and help fix it

If you agree to these terms please continue. If for any chance you disagree, please leave this repository. Thank you.

# Basic Help #
 
 The help section of this program will show you the possible flags and how to run this program
  - Type flag (-t) will tell the program what type of email you want.
   - To run this use `ruby email_gen -t` <email-type-here>`
     - Email types include:

       - `ruby gen_email.rb -t osha` <= creates osha regional email
       - `ruby gen_email.rb -t pend` <= creates a pending email (days are automatically calculated for 6 business days)
       - `ruby gen_email.rb -t 60` <= creates a 60 day hold email (account deletion)
       - `ruby gen_email.rb -t generic` <= creates a generic email (an email to say hey this is happening)
       - `ruby gen_email.rb -t resolve` <= creates a resolve email
       - `ruby gen_email.rb -t esc` <= creates an escalation email
       - `ruby gen_email.rb -t pii` <= creates an email requesting for removal of Personal info
       - `ruby gen_email.rb -t vip` <= Creates a VIP email (need to enter some info manually)
       - `ruby gen_email.rb -t inop` <= Creates a IN-OP email (need to enter some info manually)
       - `ruby gen_email.rb -t dev=<unlock or reset> <= Creates a dev account email if no flag is given defaults to unlock`
       
 - How to copy and paste into a terminal
   - Step one: On the very top of the terminal right click
   - Step two: Go to 'Properties'
   - Step three: In the 'Edit Options' section click the box that says 'QuickEdit Mode', also click the
    'Insert Mode' if it isn't checked
   - Step four: In the command history change the number of buffers to 999
   - Push 'OK'
   
   Now to test, copy this 'testing the copy' using CNTRL-C after that go to your terminal and right click
   it should copy over to the terminal. That is what you will need to do to copy, CNTRL-C, right click.
   
 - Help flag (-h) prints the basic command help page
   - To run this use `ruby email_gen --help` this will print a basic list of commands available.
   
 - Version flag (--version) shows the current version of the program
   - To run this flag user: `ruby gen_email.rb --version` this will display the current version of the program
   
 - Example flag (--example) prints an example of a generated email.
   - to run this use `ruby email_gen --example` this will print a generic email example
   
 - Test flag (--test) runs a series of test on the program to check if there any any excpetions thrown during the
 process
   - to run this do the following `ruby gen_email.rb --test` this will run the test module

 - Tutorial flag (--tutorial) runs the program tutorial
   - to run this do the following `ruby gen_email.rb --tutorial` this will take you through the tutorial
 
 # Basic information #
 
  This program was created to make your life easier, please be patient with releases. If you find a
  bug in the program or find something that could be done better, please tell me and I will do my best
  to look into it (checkout the suggestion and issues text file.) It's not to difficult and is an open
  source project, which means you are able to add, edit, remove, and change everything at your request.
  This program has no license and is free to distribute.
  
  To run the installation process you will need to cd into the current directory and run setup

  Command: cd C:\Users\<YOUR USERNAME>\Desktop\email\initial_setup
 
 Ruby setup instructions:
     - English
     - I accept the License
     - Click the Add Ruby executables to your PATH
     - Install
 
 To verify that it installed correctly, open a CMD and type 'irb' if something happens your golden, if nothing
 happens contact Tme for additional assistance. Also log the error (if you get one) into the text files
 issues.txt and send it to me with the subject gen_email issue 
