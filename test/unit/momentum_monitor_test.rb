require 'test_helper'
require 'momentum'

class MomentumMonitorTest < ActiveSupport::TestCase
  context "Momentum" do
    context "Monitor" do
      setup do
        @monitor = Momentum::Monitor.new
        @span = Momentum::Span.new(Time.now, Time.now)        
        @monitor.idle = @span
        Momentum::Checker::OSX.stubs(:current_idle_time).returns(Momentum::Config.interval - 1)
        Momentum::Config.user = nil
      end
      
      should "start a new idle span if there is none" do
        @monitor.send(:process_idle)
        assert_not_nil @monitor.idle
      end
      
      should "start a new idle span if the idle time reset" do
        @monitor.send(:process_idle)
        assert_not_equal @monitor.idle, @span
        assert_not_nil @monitor.idle
      end

      should "not start a new idle span if the idle time has not been reset" do
        Momentum::Checker::OSX.stubs(:current_idle_time).returns(999)
        @monitor.send(:process_idle)
        assert_equal @monitor.idle, @span
      end
      
      should "add the current idle to the list of spans" do
        @monitor.spans = []
        @monitor.send(:process_idle)
        assert_contains @monitor.spans, @span
      end
      
      should "add the current idle to the list of spans when blurring" do
        @monitor.activity = Activity.new
        @monitor.spans = []
        @monitor.blur
        assert_contains @monitor.spans, @span
      end
      
    end
  end
end
