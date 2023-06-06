require 'user'
require 'active_record'
require 'listing'
require_relative './database_connection'

DatabaseConnection.establish_database_connection

class Booking < ActiveRecord::Base
  belongs_to :user
  has_one :listing, through: :user, source: :listings
  
   @bookings = []

  def self.all_bookings
    Booking.joins(:user).map do |booking|
      @bookings << "#{booking.user.name} #{booking.listing.listing_name} #{booking.date_from} #{booking.date_to} #{booking.price_total} #{booking.listing.location}"
    end
    @bookings
  end

  def self.create_booking(date_from, date_to, price_total, user_id)
    booking = Booking.new(date_from: date_from, date_to: date_to, user_id: user_id)
    booking.save
    booking
  end
  
end