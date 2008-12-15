RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :session_key => '_impulse_session',
    :secret      => '3a16f9e0dcbf1344f04b5104ff49329b1814f2ab89382fa691fcf22e894732401c45b44045b64f1854524971d21d17a9f619f70beef3ebd5a0b580f10d065f6b'
  }
end

require 'time_extension'