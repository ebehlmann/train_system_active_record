require 'active_record'
require 'rspec'

require './lib/line'
require './lib/station'
require './lib/stop'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
	config.after(:each) do
		Station.all.each { |station| station.destroy }
		Stop.all.each { |stop| stop.destroy }
		Line.all.each { |line| line.destroy }
	end
end