require 'booking'
# require 'reset_tables'

RSpec.describe Booking do
#   before(:each) do 
#     reset = ResetTables.new
#     reset.reset_posts_table
#   end

  it 'return all bookings from the database' do
    expect(Booking.all_bookings[0]).to include("6300.0")
  end

  it 'creates a new booking and returns the table' do
    Booking.create_booking(3, 1, "2023-08-20", "2023-08-25")
    expect(Booking.all_bookings[-1]).to include("2023-08-20")
  end
end