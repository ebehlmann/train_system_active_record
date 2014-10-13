require 'active_record'
require './lib/station'

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

def train_station_add
	puts "What's the name of the station?"
	station_name = gets.chomp
	puts "What's the location of the station?"
	location = gets.chomp
	puts "What time does it open?"
	open_time = gets.chomp
	puts "Does it have a restaurant? Type 'y' for yes or 'n' for no."
	restaurant_answer = gets.chomp

	if restaurant_answer == 'y'
		restaurant_boolean = true
	elsif restaurant_answer == 'n'
		restaurant_boolean = false
	else
		puts "Sorry, that wasn't a valid submission."
	end

	station = Station.new({name: station_name, location: location, opens: open_time, restaurant: restaurant_boolean})
	station.save
	puts "#{station_name} has been added."
end

welcome