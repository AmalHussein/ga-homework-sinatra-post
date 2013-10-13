require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

subway = {
red: ["south station", "park st", "kendall", "central", "harvard", "porter", "davis", "alewife"], 
green: ["haymarket-GR", "government center", "park st", "bolyston", "arlington", "copley"] , 
orange: ["north station", "haymarket-OR", "park st", "state", "downtown crossing", "chinatown", "back bay", "forest hills"]
}

def total_stops(start_line, end_line, start_stop, end_stop, subway)
	if start_line == end_line
		same_track = subway[start_line.to_sym]
		same_track_start = same_track.index(start_stop)
		same_track_end = same_track.index(end_stop)
		same_line_stops = (same_track_start.to_i - same_track_end.to_i).abs
		total_stops = same_line_stops
	else 

		first_track = subway[start_line.to_sym]
		second_track = subway[end_line.to_sym]
		trip_start = first_track.index(start_stop)
		trip_switch1 = first_track.index("park st")
		trip_switch2 = second_track.index("park st")
		trip_end = second_track.index(end_stop)
		first_part = (trip_start.to_i - trip_switch1.to_i).abs
		second_part = (trip_switch2.to_i - trip_end.to_i).abs
		two_line_stops = (first_part.to_i - second_part.to_i).abs
		total_stops = two_line_stops	
	end
  	return stops
end 

get '/' do 
	erb :mbta_index
end 

get '/tripcalc' do 
	erb :mbta_stops
end 


post '/stops' do 
start_stop, start_line = (params[:start]).split(",")
end_stop , end_line = (params[:end]).split(",")
@trip_total = stops(start_line, end_line, start_stop, end_stop,subway)
	redirect '/tripcalc'
end 