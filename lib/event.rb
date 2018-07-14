class Event
  def initialize(group:, title:, duration:, date:, time:, venue:)
    @group    = group
    @title    = title
    @duration = duration
    @date     = date
    @time     = time
    @venue    = venue
  end

  attr_reader :group, :title, :duration, :date, :time, :venue
end
