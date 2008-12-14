trap "SIGINT" do
  Momentum::Monitor.default.blur
  exit
end
 
loop do
  Momentum::Monitor.process
  sleep Momentum::Config.interval
end