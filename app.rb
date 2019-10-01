require 'sinatra'
require_relative 'lib/meetups_list'
set :port, ENV['PORT'] || 4567

get '/' do
  status 200
  @events ||= MeetupsList.new.next_events
  erb :'index.html'
end
