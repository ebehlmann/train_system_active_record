require 'spec_helper'

describe Station do
	it 'has many stops' do
		station = Station.create({name: 'NEW'})
		line1 = Line.create({name: 'Southwest Chief'})
		line2 = Line.create({name: 'Missouri River Runner'})
		stop1 = Stop.create({station_id: station.id, line_id: line1.id})
		stop2 = Stop.create({station_id: station.id, line_id: line2.id})
		expect(station.stops).to eq([stop1, stop2])
	end

	it 'has many lines through stops' do
		station = Station.create({name: 'NEW'})
		line1 = Line.create({name: 'Southwest Chief'})
		line2 = Line.create({name: 'Missouri River Runner'})
		stop1 = Stop.create({station_id: station.id, line_id: line1.id})
		stop2 = Stop.create({station_id: station.id, line_id: line2.id})
		expect(station.lines).to eq([line1, line2])
	end
end