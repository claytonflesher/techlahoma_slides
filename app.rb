require 'sinatra'
require 'net/http'
require_relative 'lib/meetups_list'

get '/' do
  status 200
  @events ||= MeetupsList.new.next_events
  erb :index
end
