require 'user'
require 'active_record'
require_relative './database_connection'

DatabaseConnection.establish_database_connection

class Listing < ActiveRecord::Base
  belongs_to :user
  
   @listings = []

  def self.all_listings
    Listing.joins(:user).map do |listing|
      @listings << "#{listing.user.name} #{listing.listing_name} #{listing.availible_from} #{listing.availible_to} #{listing.price_per_night} #{listing.location}"
    end
    @listings
  end

  def self.create_listing(listing_name, availible_from, availible_to, price_per_night, location, user_id)
    listing = Listing.new(listing_name: listing_name, availible_from: availible_from, availible_to: availible_to, price_per_night: price_per_night, location: location,user_id: user_id)
    listing.save
    listing
  end
  
end