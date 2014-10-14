require 'spec_helper'

describe Stop do
	it 'belongs to a station' do
		station = Station.create({name: 'NEW'})
		line = Line.create({name: 'Southwest Chief'})
		stop = Stop.create({station_id: station.id, line_id: line.id})
		expect(stop.station).to eq(station)
	end

	it 'belongs to a line' do
		station = Station.create({name: 'NEW'})
		line = Line.create({name: 'Southwest Chief'})
		stop = Stop.create({station_id: station.id, line_id: line.id})
		expect(stop.line).to eq(line)
	end
end