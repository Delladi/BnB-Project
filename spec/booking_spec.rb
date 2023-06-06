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

  xit 'creates a new post and returns the table' do
    Post.create_post(Time.now, 'Its Friday', 2)
    expect(Post.all_peeps[-1]).to include("Its Friday")
  end
end