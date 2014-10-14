require 'spec_helper'

describe Stop do
	it 'belongs to a station' do
		station = Station.create({name: 'NEW'})
		line = Line.create({name: 'Southwest Chief'})
		stop = Stop.create({station_id: station.id, line_id: line.id})
		stop.station.should eq station
	end

	it 'belongs to a line' do
		station = Station.create({name: 'NEW'})
		line = Line.create({name: 'Southwest Chief'})
		stop = Stop.create({station_id: station.id, line_id: line.id})
		stop.line.should eq line
	end
end