# All the templates are taken straight from the KB (docs) and will be updated according to the document updates.
# This is really the only reason it should be updates, unless I screw up somewhere and it needs to be done as a hotfix.

module Templates

  class EmailTypes

    ##########################
    # Pending email template ###
    ##########################

    def pend
      advocate = get_advocate
      email = <<-_END_
 ** ADVOCATES: #{advocate} **
    
#{header} #{users_name},

Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request #{summary}; Ticket# INC00000#{verify_digits(num)} was created.
To continue processing your request, please provide the following information:
#{body}

**Please respond before #{check_date}, or your ticket will automatically close.**

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R,
#{get_user}
IT DEPARTMENT
      _END_
      copy(email)
    end

    ##########################
    # Generic email template ###
    ##########################

    def generic

      email = <<-_END_
#{header} #{users_name},

Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request #{summary}; Ticket# INC00000#{num}.

#{body}

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R,
#{get_user}
IT DEPARTMENT
      _END_
      copy(email)
    end

    #################################
    # Sixty day hold email template ###
    #################################

    def sixty_day

      email = <<-_END_
#{header} #{users_name},

Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request to delete #{account}'s account;
 
Ticket# INC00000#{verify_digits(num)} has been created for your request. OCIO has received your account deletion request.  The user's account has been disabled.  In accordance with 
AOL's interim policy, the user's data, including email, will be retained for 60 days. If there are any  extenuating circumstances
(e.g. Political Appointee, Litigation Hold) regarding the retention of this user's data, besides the instructions contained in the original request, please contact the Enterprise Service Desk.  
Otherwise, the data will be deleted after the standard 60-day hold.

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R,
#{get_user}
IT DEPARTMENT
      _END_
      copy(email)
    end

    ################################
    # OSHA regional email template ###
    ################################

    def osha_reg
      name = poc_name
      email = <<-_END_
#{header} #{users_name},

Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request #{ticket_summary = summary};

Ticket# INC00000#{ticket_number = verify_digits(num)} has been created for your request.
We have assigned your request to OSHA local support for resolution.

Please contact your regional support POC for updates concerning this ticket.

Regional Support POC:
Name: #{cap_name(name)}
Phone: #{get_poc_num(name)}
Email: #{email_to_send = get_poc_email(name)}

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R,
#{get_user}
IT DEPARTMENT
      _END_

      copy(email)
      FORMAT.info('Copied user email press enter to continue to POC email..')
      STDIN.gets.chomp
      osha_poc_email(email_to_send, ticket_summary, ticket_number, name)
    end

    def osha_poc_email(email, sum, num, info)
      poc_email = <<-_POC_
    ** SEND TO: #{get_poc_inbox(info)};#{email};Gomez.Yasmin@aol.com;Legesse.Gizaw@aol.com **

The DOL IT Enterprise Service Desk has received a request for assistance with a user being #{sum}.
Ticket# INC00000#{num} has been created and the request is being forwarded to OSHA local support
in the attached PDF ticket for resolution.

Please reply to this ticket within 6 business days if further action is required from the ESD.
If no response is received via phone or email, this ticket will automatically close.

If you have any further questions or need additional assistance;
please call the IT DEPARTMENT at
435-909-5633
or email at
IT-servicedesk@aol.com

V/R,
#{get_user}
IT DEPARTMENT
      _POC_

      copy(poc_email)
      FORMAT.info('Copied POC email.')
    end

    ################################
    # Examples page email template ###
    ################################

    def examples_page
      rand_num = rand 10000000..99999999
      work_around = File.readlines('./lib/tools/random_workarounds').sample
      rand_request = File.readlines('./lib/tools/random_problems').sample
      rand_name = File.readlines('./lib/tools/random_names').sample

      <<-_END_

This is an example of a generic email:

#{header} #{rand_name.chomp},

Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request #{rand_request.chomp}; Ticket# INC00000#{rand_num.to_s.chomp}.

Have you attempted to perform the following actions:

#{work_around.chomp}

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R,
#{get_user}
IT DEPARTMENT
      _END_
    end

    ##########################
    # Resolve email template ###
    ##########################

    def resolve
      number = verify_digits(num)
      resolution = res
      close_date = check_date
      email = <<-_END_

#{header} #{users_name},

Incident ID: INC00000#{number}
Summary: #{summary}
Enterprise Service Desk Incident INC00000#{number} has been Resolved.
Resolution: #{resolution}

**
If this incident/request has not been resolved to your satisfaction, you will have until 
#{close_date} to respond.  After this date, your ticket will close. For further information, please
contact the ESD at:
**

1-855-LABOR-IT (1-855-522-6748)
EnterpriseServiceDesk@aol.com

V/R,
#{get_user}
IT DEPARTMENT
      _END_
      copy(email)
      FORMAT.info('Resolution email has been copied..')
      FORMAT.info('Press enter to copy resolution status..')
      STDIN.gets.chomp
      res_stat = <<-_END_
#{Date.today.to_s} #{Time.now.strftime('%I:%M:%S %p')}
#{resolution}. Need user to confirm that the request is resolved by #{close_date}
      _END_
      copy(res_stat)
      FORMAT.info('Resolution status has been copied.')
    end

    #############################
    # Escalation email template ###
    #############################

    def assign
      email = <<-_END_
#{header} #{users_name}, 
	
Thank you for contacting the DOL IT Enterprise Service Desk. In regard to your request/issue
#{summary}; Ticket#INC00000#{verify_digits(num)} has been created for your request/issue.

We have assigned your request/issue to #{res_group} for resolution.

If you have any further questions or need additional assistance please call the IT DEPARTMENT via phone at:
435-909-5633
Or contact us via email at:
IT-servicedesk@aol.com.

V/R, 
#{get_user} 
IT DEPARTMENT
      _END_
      copy(email)
    end

    ###########################################
    # Removal of personal info email template ###
    ###########################################

    def remove_pii
      ticket = verify_digits(num)
      email = <<-_END_

** TO: Murphy.corey.b@aol.com;Aquino.russell.s@aol.com **
** CC: Ashburn.mark.d@aol.com **
** Subject: PII in Remedy Ticket# INC00000#{ticket} **

Ticket: INC00000#{ticket}
Please remove Work detail Entry time stamped: #{verify_timestamp(timestamp)}
If you have any further questions or need additional assistance please call the IT DEPARTMENT

Via phone at 435-909-5633
or email at IT-servicedesk@aol.com.
	
V/R, 
#{get_user} 
IT DEPARTMENT
      _END_
      FORMAT.warning('Send through DOL Outlook NOT Remedy')
      copy(email)
    end

    ###################################
    # Inoperative user email template ###
    ###################################

    def in_op_user
      ticket = verify_digits(num)
      email = <<-_END_

    ** SUBJECT: Inoperable User Ticket# #{ticket} **
    ** TO: zzVipAlert [;zzOASAM-RO-ITSTAFF-FED] **

User's Name: #{users_name}
User's Agency: #{agency}
User's ID: #{user_id}
Domain: 
Street Address: 
City: 
State: 
Room Number: 
Contact Phone: #{phone_num}
User's Issue: #{summary}
Escalated to: #{res_group}
V/R, 
#{get_user}
      _END_
      FORMAT.warning('Enter users address manually, in process of being fixed')
      copy(email)
    end

    ######################
    # VIP email template ###
    ######################

    def vip_user
      ticket = verify_digits(num)
      email = <<-_END_

    ** SUBJECT: VIP Alert Remedy Ticket# #{ticket} **
    ** TO: Whoever's escalating the ticket **

VIP's Name: #{users_name}
VIP's Agency: #{agency}
VIP's ID: #{user_id}
Street Address: 
City: 
State: 
Room Number: 
Contact Phone: #{phone_num}
VIP's Issue: #{summary}
Escalated to: #{res_group}
V/R, 
#{get_user}
      _END_
      FORMAT.warning('Enter users address manually, in process of being fixed')
      copy(email)
    end

    ##################################
    # Unlock/Reset dev account email ###
    ##################################

    def dev_account(type)
      ticket_num = verify_digits(num)
      dev_user = users_name
      dev_id = user_id
      domain = dev_domain
      server = dev_server

      unlock = <<-_UNLOCK_
** SUBJECT: RE: INC00000#{ticket_num} - DEV Account Unlock Request **
** TO: zzNuAxis@aol.com **
** CC: ocio.remedy@aol.com **

User ID: #{dev_id}
Customer Name: #{dev_user}
Domain - #{domain}
Server: #{server}

V/R
#{get_user}
IT DEPARTMENT
      _UNLOCK_

      reset = <<-_RESET_
** SUBJECT: RE: INC00000#{ticket_num} - DEV Account Password Reset Request **
** TO: zzNuAxis@aol.com **
** CC: ocio.remedy@aol.com **

User ID: #{dev_id}
Customer Name: #{dev_user}
Domain - #{domain}
Server: #{server}

V/R
#{get_user}
IT DEPARTMENT
      _RESET_

      if type =~ /unlock/
        email_type = unlock
      elsif type =~ /reset/
        email_type = reset
      else
        FORMAT.warning('No flag given defaulting to unlock')
        email_type = unlock
      end

      copy(email_type)
    end

    #########################
    # Cancel ticket request ###
    #########################

    def cancel_ticket
      cancel_num = verify_digits(request_cancel)
      ticket_num = verify_digits(num)
      cancel = <<-_EMAIL_
** SUBJECT: Duplicate ticket cancellation request Ticket# INC00000#{cancel_num} **
** TO: Pathipvanich.Parima@aol.com **
** CC: Rowe.Richard.T@aol.com;Majcen.AshLeigh@aol.com **

Ticket# INC00000#{cancel_num} is a duplicate of Ticket# INC00000#{ticket_num}

Ticket has been placed in pending -> support contact hold.
Resolution has been placed 'Duplicate of INC00000#{ticket_num}'.
A relationship has been between the two tickets.

Ticket was created by me #{get_user}.
On #{Date.today}

I am requesting to have Ticket# INC00000#{cancel_num} cancelled. My request is due to this ticket being a duplicate of
Ticket# INC00000#{ticket_num}. Please verify that you received this request. Thank you.

V/R.
#{get_user}
IT DEPARTMENT

                  _EMAIL_
      copy(cancel)
      FORMAT.warning('Send through DOL NOT Remedy')
    end

  end

end 