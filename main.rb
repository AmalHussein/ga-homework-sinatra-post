require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

subway = {

red: ["south station", "park st", "kendall", "central", "harvard", "porter", "davis", "alewife"], 
green: ["haymarket-GR", "government center", "park st", "bolyston", "arlington", "copley"] , 
orange: ["north station", "haymarket-OR", "park st", "state", "downtown crossing", "chinatown", "back bay", "forest hills"]
}

def same_line_trip(start_line, end_line, start_stop, end_stop, subway)
	same_track = subway[start_line.to_sym]
	same_track_start = same_track.index(start_stop)
	same_track_end = same_track.index(end_stop)
	same_line_stops = (same_track_start.to_i - same_track_end.to_i).abs
	
	return same_line_stops
end

def two_line_trip(start_line, end_line, start_stop, end_stop, subway)
	first_track = subway[start_line.to_sym]
	second_track = subway[end_line.to_sym]
	trip_start = first_track.index(start_stop)
	trip_switch1 = first_track.index("park st")
	trip_switch2 = second_track.index("park st")
	trip_end = second_track.index(end_stop)
	first_part = (trip_start.to_i - trip_switch1.to_i).abs
	second_part = (trip_switch2.to_i - trip_end.to_i).abs
	two_line_stops = (first_part.to_i - second_part.to_i).abs

	return two_line_stops
end


get '/' do 
	erb :mbta_index
end 

post '/mbta_stops' do 

end 

# 	if start_line == end_line
# 		puts "Below are the stops you will be marking today:"
# 		puts same_line_trip(start_line, end_line, start_stop, end_stop,subway)
# 		else	

# 		puts "Looks like you will be making some switches today! Below are the number of stops you will be making:"
# 		puts two_line_trip(start_line, end_line, start_stop, end_stop,subway)
# 	end		

# puts "Enjoy your trip to #{end_stop}"

# puts "Thanks for using Amal's Trip Planner"
