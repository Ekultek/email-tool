# Uses a batch file that will copy from a file to the users clipboard. I couldn't get the cmd copy command to work
# properly so I had to find another way around it.

module ClipBrd

  class CopyToClipboard

    # Call the batch file 'cliptext.exe' and tell it where to copy from.
    # @return [String]='The completed email'
    def copy_to_clipbrd
      `lib/tools/cliptext.exe from lib/tools/tmp/email_to_copy`
    end

  end

end