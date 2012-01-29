#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), '..', 'config', 'environment')

Resque::Failure.count.times do |i|
  Resque::Failure.requeue(i)
end

Resque::Failure.clear
