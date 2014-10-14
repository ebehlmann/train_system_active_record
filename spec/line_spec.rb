require 'spec_helper'

describe Line do
	it 'has many stops' do
		station1 = Station.create({name: 'NEW'})
		station2 = Station.create({name: 'STL'})
		line1 = Line.create({name: 'Southwest Chief'})
		stop1 = Stop.create({station_id: station1.id, line_id: line1.id})
		stop2 = Stop.create({station_id: station2.id, line_id: line1.id})
		expect(line1.stops).to eq([stop1, stop2])
	end

	it 'has many stations through stops' do
		station1 = Station.create({name: 'NEW'})
		station2 = Station.create({name: 'STL'})
		line1 = Line.create({name: 'Southwest Chief'})
		stop1 = Stop.create({station_id: station1.id, line_id: line1.id})
		stop2 = Stop.create({station_id: station2.id, line_id: line1.id})
		expect(line1.stations).to eq([station1, station2])
	end
end