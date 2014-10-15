require 'active_record'
require './lib/station'
require './lib/line'
require './lib/stop'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
	puts "Welcome to the train guide!"
	main_menu
end

def main_menu
	log_in_choice = nil
	until log_in_choice == 'x'
		puts "Press 'p' if you're a passenger or 'o' if you're an operator"
		puts "Press 'x' to exit"
		log_in_choice = gets.chomp

		case log_in_choice
		when 'p'
			passenger_menu
		when 'o'
			operator_menu
		when 'x'
			puts "Goodbye!"
		else
			puts "Sorry, that wasn't a valid option."
		end
	end
end

def passenger_menu
	passenger_choice = nil
	until passenger_choice == 'x'
		puts "Welcome, passenger."
		puts "Press 's' to see a list of train stations or 'l' to see a list of lines."
		puts "Press 'x' to exit."
		passenger_choice = gets.chomp

		case passenger_choice
		when 's'
			puts "Here are a list of stations. Enter a station number to see details."
			station_list
		when 'l'
			puts "Here are a list of lines. Enter a line number to see details."
			line_list
		when 'x'
			puts "Goodbye!"
		else
			puts "Sorry, that wasn't a valid option."
		end
	end
end

def station_list
	puts "Here are all the stations."
	stations = Station.all
	stations.each { |station| puts "#{station.id}. #{station.name}, #{station.location}"}
end

def line_list
	puts "Here are all the lines."
	lines = Line.all
	lines.each { |line| puts "#{line.id}. #{line.name}"}
end

def operator_menu
	operator_choice = nil
	until operator_choice == 'x'
		puts "Welcome, operator."
		puts "Press 't' to add a train station, 'l' to add a line or 's' to add a stop. Or press 'd' to delete something."
		puts "Press 'x' to exit."
		operator_choice = gets.chomp

		case operator_choice
		when 't'
			train_station_add
		when 'l'
			line_add
		when 's'
			stop_add
		when 'd'
			delete_menu
		when 'x'
			puts "Goodbye!"
		else
			puts "Sorry, that wasn't a valid option."
		end
	end
end

def booleanerator(submission)
	if submission == 'y'
		true
	elsif submission == 'n'
		false
	else
		puts "Sorry, that's not a valid input."
	end
end

def train_station_add
	puts "What's the name of the station?"
	station_name = gets.chomp
	puts "What's the location of the station?"
	location = gets.chomp
	puts "What time does it open?"
	open_time = gets.chomp
	puts "Does it have a restaurant? Type 'y' for yes or 'n' for no."
	restaurant_answer = gets.chomp

	restaurant_boolean = booleanerator(restaurant_answer)

	station = Station.new({name: station_name, location: location, opens: open_time, restaurant: restaurant_boolean})
	station.save
	puts "#{station_name} has been added."
end

def line_add
	puts "What's the name of the line?"
	line_name = gets.chomp
	puts "What's the price in dollars to ride the full line?"
	price = gets.chomp
	puts "How many seats are available?"
	seats = gets.chomp
	puts "Can riders check bags? Type 'y' for yes or 'n' for no."
	bags_answer = gets.chomp
	bags_boolean = booleanerator(bags_answer)
	puts "Are meals served on board? Type 'y' for yes or 'n' for no."
	meals_answer = gets.chomp
	meals_boolean = booleanerator(meals_answer)

	line = Line.new({name: line_name, price: price, seats: seats, bagcheck: bags_boolean, meals: meals_boolean})
	line.save
	puts "The #{line_name} line has been added."
end

def stop_add
	puts "Here is a list of stations. Enter the number for the station where your stop takes place."
	station_list
	station_id = gets.chomp.to_i

	puts "Here is a list of lines. Enter the number for the line making the stop."
	line_list
	line_id = gets.chomp.to_i

	puts "What time does the stop take place?"
	time = gets.chomp

	stop = Stop.new({station_id: station_id, line_id: line_id, time_of_stop: time})
	stop.save
	puts "Your stop has been added."
end

def delete_menu
	delete_choice = nil
	until delete_choice == 'x'
		puts "Press 't' to delete a train station, 'l' to delete a line or 's' to delete a stop."
		puts "Press 'x' to exit."
		delete_choice = gets.chomp

		case delete_choice
		when 't'
			station_delete
		when 'l'
			line_delete
		when 's'
			stop_delete
		when 'x'
			puts "Goodbye!"
		else
			puts "Sorry, that wasn't a valid option."
		end
	end
end

def station_delete
	puts "Here is a list of stations. Enter the number for the one you want to delete."
	station_list
	station_id = gets.chomp
	Station.delete(station_id)
end

def line_delete
	puts "Here is a list of lines. Enter the number for the one you want to delete."
	line_list
	line_id = gets.chomp
	Line.delete(line_id)
end

def stop_delete
	puts "Here are a list of stops. Enter the number for the one you want to delete."
	stops = Stop.all
	stops.each do |stop|
		stop_station = Station.where("id = #{stop.station_id}")
		stop_line =	Line.where("id = #{stop.line_id}")
		puts "#{stop.id}. #{stop_line.first.name} at #{stop_station.first.location} at #{stop.time_of_stop}"
	end
	stop_id = gets.chomp
	Stop.delete(stop_id)
end

welcome