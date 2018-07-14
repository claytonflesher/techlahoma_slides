class Venue
  def initialize(name:, address:, city:, country:, state:)
    @name    = name
    @address = address
    @city    = city
    @country = country
    @state   = state
  end

  attr_reader :name, :address, :city, :country, :state
end
