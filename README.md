# WeatherBear
*Just the bare essentials of a daily forecast*

## Versions and Dependencies

* Ruby 3.0.0
* Ruby on Rails 7.1.3
* PostgreSQL 14/15

## Setup

* Clone this repo!
* Copy application.yml.template => application.yml
* Fill in valid API keys for [geocoding](https://geocode.maps.co) and [weather](https://www.weatherapi.com)
* Create the database (./bin/rails db:create)
* Run migrations (./bin/rails db:migrate)
* Start up the server! (./bin/dev)
* Visit [localhost:3000](http://127.0.0.1:3000) in your web browser

## What's It Do?

Enter an address or zip code and it'll bring up the current weather! It'll include the current temperature, today's high and low, a text description of the conditions, and a pleasant little icon.

## Is It Clever?

Yep! Here's how it tries to figure out what weather to display.

* If you enter a zip code, it uses that! Yay!
* If you enter an address, it attempts to extract the zip code
* If that fails, it does a reverse geocoding lookup to find the zip code
* If THAT fails, it gives up and everyone is sad


## Does The Bear Tell A Joke?

He sure does! Hans is hilarious.
