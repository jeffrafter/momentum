require 'factory_girl'

Factory.define :activity do |f|
  f.start_time 10.minutes.ago
  f.end_time 8.minutes.ago
  f.idle_time 11.7
  f.application 'Garage Muppet'
  f.window 'Fozzie Bear Remix'
  f.path '/Macintosh HD/Applications/Garage Muppet.app'
end

Factory.define :category do |f|
  f.name 'Zen'
  f.description 'Know well what leads you forward'
  f.url 'http://temp.zen'
  f.color nil
end

Factory.define :interval do |f|
  f.start_time 6.minutes.ago
  f.end_time Time.now
  f.idle_time 51.7
  f.comment 'Best. Interval. Ever.'
end

Factory.define :user do |f|
  f.login 'piggy'
end
