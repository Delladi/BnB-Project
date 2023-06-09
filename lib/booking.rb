require 'date'
require 'active_record'
require_relative './listing'
require_relative './database_connection'

DatabaseConnection.establish_database_connection

class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  has_one :listing, through: :user, source: :listings

  def self.all_bookings
    bookings = Booking.joins(:user, :listing).map do |booking|
      "#{booking.user.name} #{booking.listing.listing_name} #{booking.date_from} #{booking.date_to} #{booking.price_total} #{booking.listing.location}"
    end
    bookings
  end

  def self.create_booking(date_from, date_to, listing_id, user_id)
    price_total = Booking.calculate_price_total(date_from, date_to, listing_id)
    booking = Booking.new(date_from: date_from, date_to: date_to, price_total: price_total, listing_id: listing_id, user_id: user_id)
    booking.save
    booking
  end
  def self.calculate_price_total(date_from, date_to, id)
    listing = Listing.find(id)
    date1 = Date.parse(date_from)
    date2 = Date.parse(date_to)
    difference = (date2 - date1).to_i
    total = difference * listing.price_per_night
  end
end
  
  
