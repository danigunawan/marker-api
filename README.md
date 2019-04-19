# Markers API

Simple API server application for the ['Make a Mark'])(https://github.com/prithsharma/make-a-mark)
application.

## Dev Setup Instructions

- Ruby version 2.5.3
- Uses PostgreSQL database. Please create databases with the commands below -

  ```bash
  $ psql
  > CREATE DATABASE marker_api_development;
  > CREATE DATABASE marker_api_test;
  ```

- Uses `dotenv` for maintaining environments. A sample env file is included [here](./env). (Please
get in touch with me for getting env secrets)
- For setting up the dev environment, install the right ruby version and then run -

  ```bash
  $ bundle install
  > # Install all gems needed for the server.

  $ bundle exec rake db:migrate
  > # Set up database schema

  $ rspec
  # If all tests pass, if everything is running as expected

  $ bundle exec rails s
  ```

- After the setup, `localhost:3000/markers` should appropriately respond with
`{ "message": "Missing token" }` in the browser.
Similarly peaceful-ocean-39135.herokuapp.com/markers responds with the 'Missing token' error.
- The application is currently hosted with Heroku, hostname: peaceful-ocean-39135.herokuapp.com

## API Specs and Considerations

- The API server supports the following API endpoints -
  - GET `/markers` - Retrieve all markers stored in the DB.
  - POST `/markers` - Create and store a new marker for the given coordinates.
  - POST `/markers/delete` - Delete the marker associated with given coordinates.
- The `Marker` model contains the `lat`, `long` attributes that uniquely identify a coordinate on
the map. Everything revolves around these.
- The API authorization is based on a pre-generated and shared JWT client access token that the
client-side application uses to communicate with the server.
- The server currently doesn't have the concept of users, but can be easily scaled to have user
authentication instead of client authentication and save markers per user.
- The first set of features comes along with a test suite containing integration tests for the APIs,
unit tests for the Authorization class and for the models.
- Uses RSpec along with `factory_bot`, `shoulda-matchers`, `faker`, `database_cleaner` for testing

## TODOs

- Support users in the API. Instead of a global store of markers, let users register themselves
and have a markers store for themselves.
