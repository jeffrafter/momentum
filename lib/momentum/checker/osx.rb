module Momentum
  module Checker
    class OSX < Checker
      def self.current_idle_time
        `ioreg -c IOHIDSystem | perl -ane 'if (/Idle/) {$idle=(pop @F)/1000000000; print $idle,"";last}'`.to_f rescue 0
      end

      def self.current_application
        # This script is a bit crazy, but when run as separate steps it was
        # common to catch an application in the middle of focus shifting
        script=<<-EOF        
          tell application "System Events" to tell (the first process whose frontmost is true)
            try
              tell its front window
                set appWindow to its name as string
              end tell
            on error errMsg number errNr
              set appWindow to "Unknown"
            end try

            try    
              set appName to its name as string
            on error errMsg number errNr
              set appName to "Unknown"
            end try

            try    
              set appPath to its file as string
            on error errMsg number errNr
              set appPath to "Unknown"
            end try
          end tell
          set newLine to ASCII character 10 as string
          appPath & newLine & appName & newLine & appWindow
        EOF
        output = `osascript -e '#{script}'`.chomp
        # We are assuming none of the collected properties will have new lines
        # We could tune this up by replacing newlines in the apple script
        app = output.split(/\n/)
        { :path => format_path(app[0]), :name => app[1], :window => app[2] }         
      end
      
      def self.format_path(path)
        '/' + path.gsub(/:$/, '').gsub(/:/, '/') rescue 'Unknown'
      end
      
      def self.current_user_login
        `whoami`.chomp
      end
    end
  end
end