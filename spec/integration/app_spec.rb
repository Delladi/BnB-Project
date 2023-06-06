require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'
# require 'database_connection'

# establish_database_connnection

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('Listings')
    end
  end

  context 'GET /signup' do
    it 'should get signup' do
      response = get('/signup')

      expect(response.status).to eq(200)
      expect(response.body).to include('Sign Up')
    end
  end

  context 'GET /login' do
    it 'should get login' do
      response = get('/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('Login')
    end
  end

  context 'GET /bookings' do
    it 'should get bookings' do
      response = get('/bookings')

      expect(response.status).to eq(200)
      expect(response.body).to include('Booking')
    end
  end

  context 'GET /listings' do
    it 'should get listings' do
      response = get('/listings')

      expect(response.status).to eq(200)
      expect(response.body).to include('Listings')
    end
  end

  context 'GET /1' do
    it 'should get stylish cottage getaway page ' do
      response = get('/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('Stylish Cottage Getaway')
    end
  end
end
