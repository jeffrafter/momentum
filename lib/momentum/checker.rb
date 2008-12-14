module Momentum
  module Checker
    def self.checker_for_platform
      return Momentum::Checker::OSX if Momentum::Config.platform == 'osx'
      raise NoCheckerAvailableForPlatformError, "(#{Momentum::Config.platform})"
    end  

    class NoCheckerAvailableForPlatformError < RuntimeError; end
  
    class Checker
      def self.current_idle_time
        raise NotImplementedError
      end

      def self.current_application
        raise NotImplementedError              
      end

      def self.current_user_login
        raise NotImplementedError
      end    
    end
  end
end