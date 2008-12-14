module Momentum
  class Config    
    cattr_accessor :checker, :user, :configuration, :settings

    def self.setup(options = {})
      load_config(options)
      load_defaults
    end
    
    def self.root
      defined?(MOMENTUM_ROOT) ? MOMENTUM_ROOT : File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
    end

    def self.environment
      (defined?(MOMENTUM_ENV) ? MOMENTUM_ENV : ENV['MOMENTUM_ENV'] || "development").to_sym
    end

    def self.[](key)
      self.setup
      return self.configuration[key.to_sym]
    end
    
    def self.[]=(key, value)
      self.setup
      self.configuration[key.to_sym] = value
      return value
    end
    
    def self.to_hash
      self.configuration
    end

  private	
  
    def self.load_config(options = {})
      self.configuration = {}
      self.settings = YAML.load_file(File.join(self.root, 'config', 'momentum.yml')) 
      self.load_settings(options)
      self.map_config
    end  
    
    def self.load_settings(options = {})
      self.settings.symbolize_keys!
      self.configuration.merge!(self.settings[self.environment].merge(options))
      self.configuration.symbolize_keys!
    end
     
    def self.map_config  
      mod = Module.new do
        Config.configuration.keys.each do |k|
          define_method(k) do
            return Config.configuration[k]
          end        
          define_method("#{k}=") do |val|
            Config.configuration[k] = val
          end
        end
      end      
      extend mod
      include mod
    end
    
    def self.load_defaults
      self.checker = Momentum::Checker.checker_for_platform    
      self.user = User.find_by_login(self.checker.current_user_login)
    end
  end  
end  