require 'date'
require 'json'
require 'net/http'
require_relative 'event'
require_relative 'venue'

class MeetupsList
  NAMES = [
    'Big-Data-in-Oklahoma-City',
    'cocoaheads-okc',
    'devopsokc',
    'freecodecamp-norman',
    'freecodecampokc',
    'ok-indiehackers',
    'okc-analytics',
    'okc-design-tech',
    'okc-fp',
    'okc-js',
    'okc-osh',
    'okc-ruby',
    'okc-sharp',
    'okcjug',
    'okcpython',
    'okcsql',
    'Oklahoma-Game-Developers',
    'ProductTank-OKC',
    'shecodesokc'
  ]

  def next_events
    @next_events ||= get_next_events
  end

  private

  def get_next_events
    NAMES.map do |name|
      path = '/' << name << '/events'
      events = JSON.parse(Net::HTTP.get('api.meetup.com', path))
      build_events(events).sort_by { |event| event.date }.first
    end.compact.sort_by { |event| event.date }
  end

  def build_events(events)
    events.map do |event|
      if event['venue'] != nil
        venue = build_venue(event)
      else
        venue = Venue.new(
          name: '',
          address: '',
          city: '',
          country: '',
          state: ''
        )
      end
      build_event(event, venue)
    end
  end

  def build_venue(event)
    Venue.new(
      name:    event['venue']['name'] || '',
      address: event['venue']['address_1'] || '',
      city:    event['venue']['city'] || '',
      country: event['venue']['country'] || '',
      state:   event['venue']['state'] || ''
    )
  end

  def build_event(event, venue)
    hours = event['duration'].to_i / (1000 * 60 * 60)
    minutes = event['duration'] / (1000 * 60) % 60
    Event.new(
      group:    event['group']['name'],
      title:    event['name'],
      duration: "#{hours} hours #{minutes} minutes",
      date:     Date.parse(event['local_date']),
      time:     Time.parse(event['local_time']),
      venue:    venue
    )
  end
end
