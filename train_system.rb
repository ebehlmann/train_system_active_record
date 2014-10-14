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

def operator_menu
	operator_choice = nil
	until operator_choice == 'x'
		puts "Welcome, operator."
		puts "Press 't' to add a train station, 'l' to add a line or 's' to add a stop."
		puts "Press 'x' to exit."
		operator_choice = gets.chomp

		case operator_choice
		when 't'
			train_station_add
		when 'l'
			line_add
		when 's'
			stop_add
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

welcome