require 'rubygems'
require 'active_record'
require 'active_support'

require File.join('momentum', 'config')
require File.join('momentum', 'checker')
require File.join('momentum', 'checker', 'osx')
require File.join('momentum', 'monitor')
require File.join('momentum', 'span')

Momentum::Config.setup
Momentum::Monitor.setup { Momentum::Monitor.new }